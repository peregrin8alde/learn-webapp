package com.gmail.peregrin8alde.rest.resource01;

import java.io.StringReader;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;

import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriBuilder;
import jakarta.ws.rs.core.UriBuilderException;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.core.Response.Status;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.DELETE;

import org.eclipse.microprofile.config.Config;
import org.eclipse.microprofile.config.spi.ConfigBuilder;
import org.eclipse.microprofile.config.spi.ConfigProviderResolver;

import com.gmail.peregrin8alde.rest.config.CustomFileConfigSource;
import com.gmail.peregrin8alde.rest.resource01.model.Book;
import com.gmail.peregrin8alde.rest.resource01.model.ErrorInfo;
import com.gmail.peregrin8alde.rest.resource01.storage.AbstractStorage;
import com.gmail.peregrin8alde.rest.resource01.storage.DatabaseStorage;
import com.gmail.peregrin8alde.rest.resource01.storage.JavaHashMapStorage;
import com.gmail.peregrin8alde.rest.resource01.storage.LocalFileSystemStorage;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.DataNotFoundException;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.StorageException;

@Path("resource01")
@Consumes("application/json")
@Produces("application/json")
public class Resource01 {

    // サーバー側で状態を維持するのは REST と言えないため、 あくまで動作確認用
    private static JavaHashMapStorage dummyStorage = new JavaHashMapStorage();

    private final boolean allowCreateByPutId = false;
    private final String configFile = "/config/restapp01/restapp01.properties";

    /* 設定 */
    private Config config;

    /* ストレージ */
    /* DB への接続プールなどの状態維持はストレージクラス側で調整 */
    private AbstractStorage bookStorage;

    public Resource01(@Context HttpHeaders headers) {
        /* 設定ファイルから設定取得 */
        // https://download.eclipse.org/microprofile/microprofile-config-2.0/apidocs/
        ConfigProviderResolver resolver = ConfigProviderResolver.instance();
        ConfigBuilder builder = resolver.getBuilder();
        config = builder.addDefaultSources().withSources(new CustomFileConfigSource(configFile)).build();

        String storageType = config.getValue("com.gmail.peregrin8alde.rest.resource01.storage.type", String.class);

        String userId = "anonymous";
        String auth = headers.getHeaderString("Authorization");
        if (auth != null) {
            /* トークンからユーザー情報取得 */
            JsonObject tokenPayload = getTokenPayload(headers);
            userId = tokenPayload.getString("sub");
        }
        System.out.println(userId);

        /* リソースクラスはリクエストのたびにインスタンスが作成されることに注意 */
        if (storageType.equals("file")) {
            String rootDir = config.getValue("com.gmail.peregrin8alde.rest.resource01.storage.file.rootdir",
                    String.class);
            if (userId.equals("anonymous")) {
                /* 匿名アクセスや公開リソース向け */
                bookStorage = new LocalFileSystemStorage(rootDir);
            } else {
                bookStorage = new LocalFileSystemStorage(rootDir, userId);
            }
        } else if (storageType.equals("db")) {
            if (userId.equals("anonymous")) {
                /* 匿名アクセスや公開リソース向け */
                bookStorage = new DatabaseStorage();
            } else {
                bookStorage = new DatabaseStorage(userId);
            }
        } else {
            bookStorage = dummyStorage;
            if (userId.equals("anonymous")) {
                /* 匿名アクセスや公開リソース向け */
            } else {
                try {
                    bookStorage.setNameSpace(userId);
                } catch (StorageException e) {
                    e.printStackTrace();
                }
                ;
            }
        }
    }

    /* Create */
    @Path("/books")
    @POST
    public Response createBook(Book book, @Context UriInfo uriInfo) {
        try {
            Book createdBook = bookStorage.insertOne(book);

            /*
             * レスポンスのレスポンスステータスコードが 201
             * （ Location に作成したリソースへのリンクを設定）
             */
            UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();
            uriBuilder.path(createdBook.getId());

            return Response.created(uriBuilder.build()).build();
        } catch (StorageException e) {
            e.printStackTrace();

            return Response.serverError().build();
        }
    }

    /* Read */
    @Path("/books")
    @GET
    public Response readBooks() {
        try {
            List<Book> books = bookStorage.find();

            return Response.ok().entity(books).type(MediaType.APPLICATION_JSON).build();
        } catch (StorageException e) {
            e.printStackTrace();

            return Response.serverError().build();
        }

    }

    @Path("/books/{id}")
    @GET
    public Response readBookById(@PathParam("id") String id, @Context UriInfo uriInfo) {
        try {
            Book book = bookStorage.findOne(id);

            return Response.ok().entity(book).type(MediaType.APPLICATION_JSON).build();
        } catch (DataNotFoundException e) {
            /* 指定された URI のリソースが存在しないという意味で 404 */
            Status status = Status.NOT_FOUND;

            /* エラー情報を JSON にしてレスポンスボディで返却 */
            UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();
            ErrorInfo errorInfo = new ErrorInfo(status.getStatusCode(),
                    UUID.randomUUID().toString(), "not found book", uriBuilder.build().toString());

            return Response.status(status).entity(errorInfo).type(MediaType.APPLICATION_JSON).build();
        } catch (StorageException e) {
            e.printStackTrace();

            return Response.serverError().build();
        }
    }

    /* Update */
    @Path("/books/{id}")
    @PUT
    public Response updateBookById(@PathParam("id") String id, Book book, @Context UriInfo uriInfo) {
        try {
            book.setId(id);

            if (allowCreateByPutId) {
                /* 新規作成を許可する場合 */

                if (bookStorage.upsertOne(id, book) == null) {
                    /* 新規追加した */
                    /*
                     * レスポンスのレスポンスステータスコードが 201
                     * （ Location に作成したリソースへのリンクを設定）
                     */
                    UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();

                    return Response.created(uriBuilder.build()).build();
                } else {
                    /* 置換した */
                    /*
                     * レスポンスのレスポンスステータスコードが 204
                     * （ 更新成功という情報があれば充分とみなして 200 は使わない方針とする）
                     */

                    return Response.noContent().build();
                }
            } else {
                /* PUT による新規作成を許可しない場合 */
                /* id は内部自動生成してるので、 id 指定で見つからないからといって、その id で新規作成されても困る */
                bookStorage.updateOne(id, book);

                /* 置換した */
                /*
                 * レスポンスのレスポンスステータスコードが 204
                 * （ 更新成功という情報があれば充分とみなして 200 は使わない方針とする）
                 */
                return Response.noContent().build();
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();

            return Response.serverError().build();
        } catch (UriBuilderException e) {
            e.printStackTrace();

            return Response.serverError().build();
        } catch (DataNotFoundException e) {
            /* 指定された URI のリソースが存在しないという意味で 404 */
            Status status = Status.NOT_FOUND;

            /* エラー情報を JSON にしてレスポンスボディで返却 */
            UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();
            ErrorInfo errorInfo = new ErrorInfo(status.getStatusCode(),
                    UUID.randomUUID().toString(), "not found book", uriBuilder.build().toString());

            return Response.status(status).entity(errorInfo).type(MediaType.APPLICATION_JSON).build();
        } catch (StorageException e) {
            e.printStackTrace();

            return Response.serverError().build();
        }
    }

    /* Delete */
    @Path("/books/{id}")
    @DELETE
    public Response deleteBookById(@PathParam("id") String id, @Context UriInfo uriInfo) {
        try {
            bookStorage.deleteOne(id);

            return Response.noContent().build();
        } catch (DataNotFoundException e) {
            /* 指定された URI のリソースが存在しないという意味で 404 */
            Status status = Status.NOT_FOUND;

            /* エラー情報を JSON にしてレスポンスボディで返却 */
            UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();
            ErrorInfo errorInfo = new ErrorInfo(status.getStatusCode(),
                    UUID.randomUUID().toString(), "not found book", uriBuilder.build().toString());

            return Response.status(status).entity(errorInfo).type(MediaType.APPLICATION_JSON).build();
        } catch (StorageException e) {
            e.printStackTrace();

            return Response.serverError().build();
        }
    }

    private JsonObject getTokenPayload(HttpHeaders headers) {

        //System.out.println("headers");
        String auth = headers.getHeaderString("Authorization");

        //System.out.println(auth);
        String bearerToken = auth.substring("Bearer ".length());
        //System.out.println("token:" + bearerToken + ":");

        String infos[] = bearerToken.split("\\.");

        try (JsonReader jsonReader = Json
                .createReader(new StringReader(new String(Base64.getUrlDecoder().decode(infos[0]))))) {
            //JsonObject jwtHeader = jsonReader.readObject();

            // System.out.println("jwtHeader:" + jwtHeader.toString());
        }

        try (JsonReader jsonReader = Json
                .createReader(new StringReader(new String(Base64.getUrlDecoder().decode(infos[1]))))) {
            JsonObject tokenPayload = jsonReader.readObject();

            // System.out.println("tokenPayload:" + tokenPayload.toString());

            return tokenPayload;
        }
    }
}
