package com.gmail.peregrin8alde.rest.resource01.storage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.gmail.peregrin8alde.rest.resource01.model.Book;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.DataNotFoundException;

public class JavaHashMapStorage extends AbstractStorage {

    private Map<String, Book> bookStorage;

    public JavaHashMapStorage() {
        bookStorage = new HashMap<String, Book>();
    }

    /* Create */
    public Book insertOne(Book book) {
        String id = UUID.randomUUID().toString();

        book.setId(id);
        bookStorage.put(id, book);

        return book;
    }

    /* Read */
    public List<Book> find() {
        List<Book> books = new ArrayList<Book>();

        /* 一度に返す数やページ数指定、ソートなどはここで調整 */
        for (Book book : bookStorage.values()) {
            books.add(book);
        }

        return books;
    }

    public Book findOne(String id) throws DataNotFoundException {
        Book book = bookStorage.get(id);

        if (book == null) {
            throw new DataNotFoundException("data not found, id : " + id);
        }

        return book;
    }

    /* Update */
    public void updateOne(String id, Book book) throws DataNotFoundException {
        if (!bookStorage.containsKey(id)) {
            throw new DataNotFoundException("data not found, id : " + id);
        }

        book.setId(id);
        bookStorage.put(id, book);
    }

    public Book upsertOne(String id, Book book) {
        book.setId(id);
        bookStorage.put(id, book);

        return book;
    }

    /* Delete */
    public void deleteOne(String id) throws DataNotFoundException {
        if (!bookStorage.containsKey(id)) {
            throw new DataNotFoundException("data not found, id : " + id);
        }

        bookStorage.remove(id);
    }
}
