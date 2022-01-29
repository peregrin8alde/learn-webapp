#!/bin/sh

mkdir -p "$PWD/data"

docker run \
  --name postgres \
  --rm \
  -d \
  --user "$(id -u):$(id -g)" \
  -v /etc/passwd:/etc/passwd:ro \
  -v "$PWD/data":/var/lib/postgresql/data \
  -v "$PWD/conf/postgresql.conf":/etc/postgresql/postgresql.conf \
  -v "$PWD/conf/pg_hba.conf":/etc/postgresql/pg_hba.conf \
  -e POSTGRES_PASSWORD=postgres \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  postgres \
    -c 'config_file=/etc/postgresql/postgresql.conf' \
    -c 'hba_file=/etc/postgresql/pg_hba.conf'


exit 0
