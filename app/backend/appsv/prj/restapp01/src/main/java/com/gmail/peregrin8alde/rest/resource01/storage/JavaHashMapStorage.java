package com.gmail.peregrin8alde.rest.resource01.storage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.gmail.peregrin8alde.rest.resource01.model.Book;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.DataNotFoundException;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.StorageException;

public class JavaHashMapStorage extends AbstractStorage {

    private Map<String, Map<String, Book>> bookStorage;

    public JavaHashMapStorage(String nameSpace) {
        bookStorage = new HashMap<String, Map<String, Book>>();

        try {
            this.setNameSpace(nameSpace);
        } catch (StorageException e) {
            e.printStackTrace();
        }
    }

    public JavaHashMapStorage() {
        this("public");
    }

    public void setNameSpace(String nameSpace) throws StorageException {
        if (!bookStorage.containsKey(nameSpace)) {
            bookStorage.put(nameSpace, new HashMap<String, Book>());
        }
        
        super.setNameSpace(nameSpace);
    }

    /* Create */
    public Book insertOne(Book book) {
        String id = UUID.randomUUID().toString();

        /* 上書き不可 */
        // 存在したらエラー

        /* 新規作成 */
        book.setId(id);
        bookStorage.get(super.getNameSpace()).put(id, book);

        return book;
    }

    /* Read */
    public List<Book> find() {
        List<Book> books = new ArrayList<Book>();

        /* 一度に返す数やページ数指定、ソートなどはここで調整 */
        for (Book book : bookStorage.get(super.getNameSpace()).values()) {
            books.add(book);
        }

        return books;
    }

    public Book findOne(String id) throws DataNotFoundException {
        Book book = bookStorage.get(super.getNameSpace()).get(id);

        if (book == null) {
            throw new DataNotFoundException("data not found, id : " + id);
        }

        return book;
    }

    /* Update */
    public void updateOne(String id, Book book) throws DataNotFoundException {
        if (!bookStorage.get(super.getNameSpace()).containsKey(id)) {
            throw new DataNotFoundException("data not found, id : " + id);
        }

        book.setId(id);
        bookStorage.get(super.getNameSpace()).put(id, book);
    }

    public Book upsertOne(String id, Book book) {
        book.setId(id);
        bookStorage.get(super.getNameSpace()).put(id, book);

        return book;
    }

    /* Delete */
    public void deleteOne(String id) throws DataNotFoundException {
        if (!bookStorage.get(super.getNameSpace()).containsKey(id)) {
            throw new DataNotFoundException("data not found, id : " + id);
        }

        bookStorage.get(super.getNameSpace()).remove(id);
    }
}
