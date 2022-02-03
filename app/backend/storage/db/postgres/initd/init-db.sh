#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE testdb TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    CREATE TABLE books (id varchar(256) PRIMARY KEY, title varchar(1024));
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "testdb" <<-EOSQL
    CREATE TABLE books (id varchar(256) PRIMARY KEY, title varchar(1024));
EOSQL
