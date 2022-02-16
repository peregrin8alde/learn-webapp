package com.gmail.peregrin8alde.rest.resource01.storage;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.json.bind.Jsonb;
import javax.json.bind.JsonbBuilder;
import javax.json.bind.JsonbConfig;

import com.gmail.peregrin8alde.rest.resource01.model.Book;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.DataNotFoundException;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.StorageException;

public class LocalFileSystemStorage extends AbstractStorage {

    private String rootDir;

    private Jsonb jsonb;

    public LocalFileSystemStorage(String rootDir, String subdir) {
        try {
            this.rootDir = rootDir;
            this.setNameSpace(subdir);

            // https://jakarta.ee/specifications/jsonb/2.0/apidocs/jakarta/json/bind/jsonbbuilder
            // https://jakarta.ee/specifications/jsonb/2.0/apidocs/jakarta/json/bind/jsonb
            // https://jakarta.ee/specifications/jsonb/2.0/apidocs/jakarta/json/bind/jsonbconfig
            JsonbConfig config = new JsonbConfig();
            config.setProperty("ENCODING", "UTF-8");
            jsonb = JsonbBuilder.create(config);
        } catch (StorageException e) {
            e.printStackTrace();
        }
    }

    public LocalFileSystemStorage(String rootDir) {
        this(rootDir, "public");
    }

    public LocalFileSystemStorage() {
        this("/storage/restapp01");
    }

    public void setNameSpace(String nameSpace) throws StorageException {
        // https://docs.oracle.com/javase/tutorial/essential/io/dirs.html
        try {
            Files.createDirectories(Paths.get(rootDir + File.separator + nameSpace));
        } catch (IOException e) {
            // キャッチせずコンストラクタ自体失敗させたいところだが、 JAX-RS 側でどう扱うべきかが不明なため暫定処理
            e.printStackTrace();
        }

        super.setNameSpace(nameSpace);
    }

    /* Create */
    public Book insertOne(Book book) throws StorageException {
        String id = UUID.randomUUID().toString();

        /* 上書き不可 */
        // 存在したらエラー

        /* 新規作成 */
        // https://docs.oracle.com/javase/tutorial/essential/io/file.html
        Path file = Paths.get(rootDir + File.separator + super.getNameSpace() + File.separator + id + ".json");
        try (BufferedWriter writer = Files.newBufferedWriter(file)) {
            book.setId(id);

            // https://jakarta.ee/specifications/jsonb/2.0/apidocs/jakarta/json/bind/jsonb
            jsonb.toJson(book, writer);

            return book;
        } catch (IOException e) {
            System.err.format("IOException: %s%n", e);

            throw new StorageException();
        }
    }

    /* Read */
    public List<Book> find() throws StorageException {
        // https://docs.oracle.com/javase/tutorial/essential/io/file.html
        Path dir = Paths.get(rootDir + File.separator + super.getNameSpace());
        try (DirectoryStream<Path> stream = Files.newDirectoryStream(dir, "*.json")) {
            List<Book> books = new ArrayList<Book>();

            for (Path entry : stream) {
                // System.out.println(entry.getFileName());

                try (BufferedReader reader = Files.newBufferedReader(entry)) {
                    // https://jakarta.ee/specifications/jsonb/2.0/apidocs/jakarta/json/bind/jsonb
                    Book book = jsonb.fromJson(reader, Book.class);

                    /* 一度に返す数やページ数指定、ソートなどはここで調整 */
                    books.add(book);
                } catch (IOException e) {
                    System.err.format("IOException: %s%n", e);

                    throw new StorageException();
                }
            }

            return books;
        } catch (IOException e) {
            System.err.format("IOException: %s%n", e);

            throw new StorageException();
        }
    }

    public Book findOne(String id) throws StorageException {
        Path file = Paths.get(rootDir + File.separator + super.getNameSpace() + File.separator + id + ".json");
        if (!Files.exists(file)) {
            /* 存在することを確認できない場合 */
            throw new DataNotFoundException("data not found, id : " + id);
        }

        try (BufferedReader reader = Files.newBufferedReader(file)) {
            Book book = jsonb.fromJson(reader, Book.class);

            return book;
        } catch (IOException e) {
            System.err.format("IOException: %s%n", e);

            throw new StorageException();
        }
    }

    /* Update */
    public void updateOne(String id, Book book) throws StorageException {
        Path file = Paths.get(rootDir + File.separator + super.getNameSpace() + File.separator + id + ".json");
        if (!Files.exists(file)) {
            /* 存在することを確認できない場合 */
            throw new DataNotFoundException("data not found, id : " + id);
        }

        try (BufferedWriter writer = Files.newBufferedWriter(file)) {
            book.setId(id);
            jsonb.toJson(book, writer);
        } catch (IOException e) {
            System.err.format("IOException: %s%n", e);

            throw new StorageException();
        }
    }

    public Book upsertOne(String id, Book book) throws StorageException {
        Path file = Paths.get(rootDir + File.separator + super.getNameSpace() + File.separator + id + ".json");
        try (BufferedWriter writer = Files.newBufferedWriter(file)) {
            book.setId(id);
            jsonb.toJson(book, writer);

            return book;
        } catch (IOException e) {
            System.err.format("IOException: %s%n", e);

            throw new StorageException();
        }
    }

    /* Delete */
    public void deleteOne(String id) throws StorageException {
        Path file = Paths.get(rootDir + File.separator + super.getNameSpace() + File.separator + id + ".json");
        try {
            // https://docs.oracle.com/javase/tutorial/essential/io/delete.html
            Files.delete(file);
        } catch (NoSuchFileException x) {
            throw new DataNotFoundException("data not found, id : " + id);
        } catch (IOException e) {
            System.err.format("IOException: %s%n", e);

            throw new StorageException();
        }
    }
}
