#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"

if [ -z $(docker network ls | grep -w "${DOCKER_NETWORK}" | awk '{print $2}') ]; then
  docker network create "${DOCKER_NETWORK}"
fi

docker run \
  --name webapp_apimng_database \
  --network="${DOCKER_NETWORK}" \
  -d \
  -v webapp_apimng_database_pgdata:/var/lib/postgresql/data \
  -e "POSTGRES_USER=kong" \
  -e "POSTGRES_DB=kong" \
  -e "POSTGRES_PASSWORD=kongpass" \
  postgres:13

sleep 5

docker run \
  --rm \
  --network="${DOCKER_NETWORK}" \
  -e "KONG_DATABASE=postgres" \
  -e "KONG_PG_HOST=webapp_apimng_database" \
  -e "KONG_PG_PASSWORD=kongpass" \
  kong:2.7.0-alpine \
    kong migrations bootstrap


exit 0
