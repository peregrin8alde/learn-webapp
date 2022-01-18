package com.gmail.peregrin8alde.rest.resource01;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriBuilder;
import jakarta.ws.rs.core.UriInfo;
import jakarta.ws.rs.core.Response.Status;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.DELETE;

import com.gmail.peregrin8alde.rest.resource01.model.Book;
import com.gmail.peregrin8alde.rest.resource01.model.ErrorInfo;

@Path("resource01")
@Consumes("application/json")
@Produces("application/json")
public class Resource01 {

    private static Map<String, Book> books = new HashMap<String, Book>();
    private final boolean allowCreateByPutId = false;

    /* Create */
    @Path("/books")
    @POST
    public Response createBook(Book book, @Context UriInfo uriInfo) {
        String id = UUID.randomUUID().toString();

        book.setId(id);
        books.put(id, book);

        /*
         * レスポンスのレスポンスステータスコードが 201
         * （ Location に作成したリソースへのリンクを設定）
         */
        UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();
        uriBuilder.path(id);

        return Response.created(uriBuilder.build()).build();
    }

    /* Read */
    @Path("/books")
    @GET
    public Map<String, Book> readBooks() {
        return books;
    }

    @Path("/books/{id}")
    @GET
    public Response readBookById(@PathParam("id") String id, @Context UriInfo uriInfo) {
        if (books.get(id) == null) {
            /* 指定された URI のリソースが存在しないという意味で 404 */
            Status status = Status.NOT_FOUND;

            /* エラー情報を JSON にしてレスポンスボディで返却 */
            UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();
            ErrorInfo errorInfo = new ErrorInfo(status.getStatusCode(),
                    UUID.randomUUID().toString(), "not found book", uriBuilder.build().toString());

            return Response.status(status).entity(errorInfo).type(MediaType.APPLICATION_JSON).build();
        }

        return Response.ok().entity(books.get(id)).type(MediaType.APPLICATION_JSON).build();
    }

    /* Update */
    @Path("/books/{id}")
    @PUT
    public Response updateBookById(@PathParam("id") String id, Book book, @Context UriInfo uriInfo) {
        book.setId(id);

        if (books.replace(id, book) == null) {
            if (allowCreateByPutId) {
                /* 新規作成を許可する場合 */
                books.put(id, book);

                /* 新規追加した */
                /*
                 * レスポンスのレスポンスステータスコードが 201
                 * （ Location に作成したリソースへのリンクを設定）
                 */
                UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();

                return Response.created(uriBuilder.build()).build();
            } else {
                /* PUT による新規作成を許可しない場合 */
                /* id は内部自動生成してるので、 id 指定で見つからないからといって、その id で新規作成されても困る */

                /* 指定された URI のリソースが存在しないという意味で 404 */
                Status status = Status.NOT_FOUND;

                /* エラー情報を JSON にしてレスポンスボディで返却 */
                UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();
                ErrorInfo errorInfo = new ErrorInfo(status.getStatusCode(),
                        UUID.randomUUID().toString(), "not found book", uriBuilder.build().toString());

                return Response.status(status).entity(errorInfo).type(MediaType.APPLICATION_JSON).build();
            }
        } else {
            /* 置換した */
            /*
             * レスポンスのレスポンスステータスコードが 204
             * （ 更新成功という情報があれば充分とみなして 200 は使わない方針とする）
             */

            return Response.noContent().build();
        }
    }

    /* Delete */
    @Path("/books/{id}")
    @DELETE
    public Response deleteBookById(@PathParam("id") String id, @Context UriInfo uriInfo) {
        if (books.remove(id) == null) {
            /* 指定された URI のリソースが存在しないという意味で 404 */
            Status status = Status.NOT_FOUND;

            /* エラー情報を JSON にしてレスポンスボディで返却 */
            UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder();
            ErrorInfo errorInfo = new ErrorInfo(status.getStatusCode(),
                    UUID.randomUUID().toString(), "not found book", uriBuilder.build().toString());

            return Response.status(status).entity(errorInfo).type(MediaType.APPLICATION_JSON).build();
        }

        return Response.noContent().build();
    }

}
