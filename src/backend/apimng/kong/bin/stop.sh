#!/bin/sh

DOCKER_DB_NAME="webapp_apimng_database"

docker stop "${DOCKER_DB_NAME}"
docker stop webapp_apimng


exit 0
