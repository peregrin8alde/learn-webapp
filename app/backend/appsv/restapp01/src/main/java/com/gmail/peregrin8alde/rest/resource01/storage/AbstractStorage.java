package com.gmail.peregrin8alde.rest.resource01.storage;

import java.util.List;

import com.gmail.peregrin8alde.rest.resource01.model.Book;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.DataNotFoundException;

public abstract class AbstractStorage {
    /*
     * エラーは例外で処理
     * 例外が発生しなければ正常
     * 正常時に情報が必要な場合のみ復帰値
     * 動作内容はログで出力
     */

    /* Create */
    /*
     * 復帰値 : Book 作成したデータ
     * 基本的には作成したデータを特定するための _id だけ分かれば良いが、
     * 他にも自動設定するパラメタが増えた場合に備えて丸ごと返す。
     */
    public abstract Book insertOne(Book book);

    /* Read */
    /* 一覧は配列で返すこととする */
    /* 内部で持つ形式とは独立させる */
    public abstract List<Book> find();

    /*
     * 例外 :
     * - DataNotFoundException : 指定した _id のデータが見つからない。
     */
    public abstract Book findOne(String id) throws DataNotFoundException;

    /* Update */
    /*
     * 例外 :
     * - DataNotFoundException : 指定した _id のデータが見つからない。
     */
    public abstract void updateOne(String id, Book book) throws DataNotFoundException;

    /*
     * 復帰値 : 
     *   - Book : 作成したデータ
     *   - null : データが作成されず置換された
     * 基本的には作成したデータを特定するための _id だけ分かれば良いが、
     * 他にも自動設定するパラメタが増えた場合に備えて丸ごと返す。
     */
    public abstract Book upsertOne(String id, Book book);

    /* Delete */
    /*
     * 例外 :
     * - DataNotFoundException : 指定した _id のデータが見つからない。
     */
    public abstract void deleteOne(String id) throws DataNotFoundException;
}
