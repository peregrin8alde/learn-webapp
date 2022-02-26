#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_DB_NAME="webapp_apimng_database"
DOCKER_DB_VOLUME="webapp_apimng_database_pgdata"

if [ -n "$(docker container ls --filter name="^${DOCKER_DB_NAME}$" -q)" ]; then
  echo "stop db"
  docker stop "${DOCKER_DB_NAME}"
fi

if [ -n "$(docker volume ls --filter name="^${DOCKER_DB_VOLUME}$" -q)" ]; then
  echo "delete db"
  docker volume rm "${DOCKER_DB_VOLUME}"
else
  echo "alreadey unsetuped"
fi


exit 0
