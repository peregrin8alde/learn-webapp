package com.gmail.peregrin8alde.rest.resource01.storage.exception;

/* 
   独自例外の基盤として共通処理を実装するクラス
*/
public class StorageException extends Exception {
    public StorageException() {
        super();
    }

    public StorageException(String s) {
        super(s);
    }
}
