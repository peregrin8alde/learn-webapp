package com.gmail.peregrin8alde.rest.resource01.model;

import javax.json.bind.annotation.JsonbProperty;

public class Book {
    /* 内部情報には JSON 上でキー名の先頭に `_` を付けることにする */
    @JsonbProperty("_id")
    private String id;
    private String title;

    public Book() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

}
