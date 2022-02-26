#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"
DOCKER_DB_NAME="webapp_apimng_database"
DOCKER_DB_VOLUME="webapp_apimng_database_pgdata"

# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z "$(docker network ls --filter name="^${DOCKER_NETWORK}$" -q)" ]; then
  docker network create "${DOCKER_NETWORK}"
fi

if [ -z "$(docker container ls --filter name="^${DOCKER_DB_NAME}$" -q)" ]; then
  docker run \
    --name "${DOCKER_DB_NAME}" \
    --network="${DOCKER_NETWORK}" \
    -d \
    --rm \
    -v "${DOCKER_DB_VOLUME}":/var/lib/postgresql/data \
    -e "POSTGRES_USER=kong" \
    -e "POSTGRES_DB=kong" \
    -e "POSTGRES_PASSWORD=kongpass" \
    postgres:13
fi


docker run \
  --name=webapp_apimng \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.apimng \
  -d \
  --rm \
  -e "KONG_DATABASE=postgres" \
  -e "KONG_PG_HOST=${DOCKER_DB_NAME}" \
  -e "KONG_PG_USER=kong" \
  -e "KONG_PG_PASSWORD=kongpass" \
  -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
  -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
  -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
  -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
  -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
  -p 8000:8000 \
  -p 8443:8443 \
  -p 127.0.0.1:8001:8001 \
  -p 127.0.0.1:8444:8444 \
  kong:2.7


exit 0
