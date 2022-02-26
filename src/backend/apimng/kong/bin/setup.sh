#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"
DOCKER_DB_NAME="webapp_apimng_database"
DOCKER_DB_VOLUME="webapp_apimng_database_pgdata"

if [ -z "$(docker network ls --filter name="^${DOCKER_NETWORK}$" -q)" ]; then
  docker network create "${DOCKER_NETWORK}"
fi

if [ -z "$(docker volume ls --filter name="^${DOCKER_DB_VOLUME}$" -q)" ]; then
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

  sleep 5

  docker run \
    --rm \
    --network="${DOCKER_NETWORK}" \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=${DOCKER_DB_NAME}" \
    -e "KONG_PG_PASSWORD=kongpass" \
    kong:2.7.0-alpine \
      kong migrations bootstrap

  docker stop "${DOCKER_DB_NAME}"
else
  echo "alreadey setuped"
fi


exit 0
