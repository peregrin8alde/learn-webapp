#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"

# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z $(docker network ls --filter name="^${DOCKER_NETWORK}$" -q) ]; then
  docker network create "${DOCKER_NETWORK}"
fi

mkdir -p "$SCRIPT_DIR/data"

docker run \
  --name webapp_db \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.postgres \
  --rm \
  -d \
  --user "$(id -u):$(id -g)" \
  -v /etc/passwd:/etc/passwd:ro \
  -v "$SCRIPT_DIR/data":/var/lib/postgresql/data \
  -v "$SCRIPT_DIR/conf/postgresql.conf":/etc/postgresql/postgresql.conf \
  -v "$SCRIPT_DIR/conf/pg_hba.conf":/etc/postgresql/pg_hba.conf \
  -v "$SCRIPT_DIR/initd":/docker-entrypoint-initdb.d \
  -e POSTGRES_PASSWORD=postgres \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  postgres \
    -c 'config_file=/etc/postgresql/postgresql.conf' \
    -c 'hba_file=/etc/postgresql/pg_hba.conf'


exit 0
