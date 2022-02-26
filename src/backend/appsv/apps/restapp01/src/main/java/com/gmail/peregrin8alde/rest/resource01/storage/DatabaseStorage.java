package com.gmail.peregrin8alde.rest.resource01.storage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.annotation.sql.DataSourceDefinition;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.gmail.peregrin8alde.rest.resource01.model.Book;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.DataNotFoundException;
import com.gmail.peregrin8alde.rest.resource01.storage.exception.StorageException;

@DataSourceDefinition(name = "java:app/MyDataSource", className = "org.postgresql.ds.PGSimpleDataSource", portNumber = 5432, serverName = "webapp_db", databaseName = "testdb", user = "postgres", password = "postgres")

public class DatabaseStorage extends AbstractStorage {
    private final String bookTblName = "books";

    // 有効になってない？
    @Resource(lookup = "java:app/MyDataSource")
    DataSource myDB;

    public DatabaseStorage(String schema) {
        Context ctx;
        try {
            ctx = new InitialContext();
            myDB = (DataSource) ctx.lookup("java:app/MyDataSource");

            this.setNameSpace(schema);
        } catch (NamingException e) {
            e.printStackTrace();
        } catch (StorageException e) {
            e.printStackTrace();
        }
    }

    public DatabaseStorage() {
        this("public");
    }

    public void setNameSpace(String nameSpace) throws StorageException {
        Connection conn = null;
        try {
            conn = myDB.getConnection();
            createBookTbl(conn);
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new StorageException(e.getMessage());
                }
            }
        }

        super.setNameSpace(nameSpace);
    }

    /* Create */
    public Book insertOne(Book book) throws StorageException {
        Connection conn = null;
        try {
            conn = myDB.getConnection();

            /* 上書き不可 */
            // 存在したらエラー

            /* 新規作成 */
            // https://jdbc.postgresql.org/documentation/head/update.html#delete-example
            // https://www.postgresql.jp/document/13/html/sql-insert.html
            // id は DB 側で自動生成して PostgreSQL の return 句などで返却したいが、標準的な構文ではないので未使用
            PreparedStatement st = conn.prepareStatement(
                    "INSERT INTO \"" + super.getNameSpace() + "\"." + bookTblName + "(id, title) VALUES (?, ?)");

            String id = UUID.randomUUID().toString();
            book.setId(id);

            st.setString(1, book.getId());
            st.setString(2, book.getTitle());
            st.executeUpdate();

            st.close();

            // return の前に finally 内の処理が実行される
            return book;
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new StorageException(e.getMessage());
                }
            }
        }
    }

    /* Read */
    public List<Book> find() throws StorageException {
        Connection conn = null;
        try {
            conn = myDB.getConnection();

            // https://jdbc.postgresql.org/documentation/head/query.html
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM \"" + super.getNameSpace() + "\"." + bookTblName);

            List<Book> books = new ArrayList<Book>();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getString(1));
                book.setTitle(rs.getString(2));

                books.add(book);
            }
            rs.close();
            st.close();

            return books;
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new StorageException(e.getMessage());
                }
            }
        }
    }

    public Book findOne(String id) throws StorageException {
        Connection conn = null;
        try {
            conn = myDB.getConnection();

            PreparedStatement st = conn.prepareStatement(
                    "SELECT * FROM \"" + super.getNameSpace() + "\"." + bookTblName + " WHERE id = ?");
            st.setString(1, id);
            ResultSet rs = st.executeQuery();

            Book book = null;
            while (rs.next()) {
                book = new Book();
                book.setId(rs.getString(1));
                book.setTitle(rs.getString(2));
            }
            rs.close();
            st.close();

            if (book == null) {
                /* 存在することを確認できない場合 */
                throw new DataNotFoundException("data not found, id : " + id);
            }

            return book;
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new StorageException(e.getMessage());
                }
            }
        }
    }

    /* Update */
    public void updateOne(String id, Book book) throws StorageException {
        Connection conn = null;
        try {
            conn = myDB.getConnection();

            PreparedStatement st = conn.prepareStatement(
                    "SELECT * FROM \"" + super.getNameSpace() + "\"." + bookTblName + " WHERE id = ?");
            st.setString(1, id);
            ResultSet rs = st.executeQuery();

            Book oldBook = null;
            while (rs.next()) {
                oldBook = new Book();
                oldBook.setId(rs.getString(1));
                oldBook.setTitle(rs.getString(2));
            }
            rs.close();
            st.close();

            if (oldBook == null) {
                /* 存在することを確認できない場合 */
                throw new DataNotFoundException("data not found, id : " + id);
            }

            st = conn.prepareStatement(
                    "UPDATE \"" + super.getNameSpace() + "\"." + bookTblName + " SET title = ? WHERE id = ?");

            book.setId(id);

            st.setString(1, book.getTitle());
            st.setString(2, book.getId());
            st.executeUpdate();

            st.close();
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new StorageException(e.getMessage());
                }
            }
        }
    }

    public Book upsertOne(String id, Book book) throws StorageException {
        Connection conn = null;
        try {
            conn = myDB.getConnection();

            PreparedStatement st = conn.prepareStatement(
                    "UPDATE \"" + super.getNameSpace() + "\"." + bookTblName + " SET title = ? WHERE id = ?");

            book.setId(id);

            st.setString(1, book.getTitle());
            st.setString(2, book.getId());
            st.executeUpdate();

            st.close();

            return book;
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new StorageException(e.getMessage());
                }
            }
        }
    }

    /* Delete */
    public void deleteOne(String id) throws StorageException {
        Connection conn = null;
        try {
            conn = myDB.getConnection();

            PreparedStatement st = conn.prepareStatement(
                    "SELECT * FROM \"" + super.getNameSpace() + "\"." + bookTblName + " WHERE id = ?");
            st.setString(1, id);
            ResultSet rs = st.executeQuery();

            Book oldBook = null;
            while (rs.next()) {
                oldBook = new Book();
                oldBook.setId(rs.getString(1));
                oldBook.setTitle(rs.getString(2));
            }
            rs.close();
            st.close();

            if (oldBook == null) {
                /* 存在することを確認できない場合 */
                throw new DataNotFoundException("data not found, id : " + id);
            }

            st = conn.prepareStatement("DELETE FROM \"" + super.getNameSpace() + "\"." + bookTblName + " WHERE id = ?");

            st.setString(1, id);
            st.executeUpdate();

            st.close();
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new StorageException(e.getMessage());
                }
            }
        }
    }

    private void createBookTbl(Connection conn) throws StorageException {
        try {
            createUserShema(conn);

            Statement st = conn.createStatement();
            st.execute("CREATE TABLE IF NOT EXISTS \"" + super.getNameSpace() + "\"." + bookTblName
                    + "(id varchar(256) PRIMARY KEY, title varchar(1024))");
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {

        }
    }

    private void createUserShema(Connection conn) throws StorageException {
        try {
            Statement st = conn.createStatement();
            st.execute("CREATE SCHEMA IF NOT EXISTS \"" + super.getNameSpace() + "\"");
        } catch (SQLException e) {
            throw new StorageException(e.getMessage());
        } finally {

        }
    }
}
