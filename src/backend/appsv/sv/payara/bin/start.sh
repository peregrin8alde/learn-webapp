#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "${SCRIPT_DIR}/../.." && pwd)

DOCKER_NETWORK="webapp-net"

LOGS_DIR="${PARENT_DIR}/logs"

WEBAPPS_DIR="${BASE_DIR}/webapps"
LIBS_DIR="${BASE_DIR}/libs"
FILE_STORAGE_DIR="${BASE_DIR}/storage"
APP_CONFIG_DIR="${BASE_DIR}/config"


# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z $(docker network ls --filter name="^${DOCKER_NETWORK}$" -q) ]; then
  docker network create "${DOCKER_NETWORK}"
fi


docker run \
  --name=webapp_appsv \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.appsv \
  -d \
  --rm \
  -p 6900:6900 \
  -v "${WEBAPPS_DIR}":/opt/payara/deployments \
  -v "${APP_CONFIG_DIR}":/config \
  -v "${FILE_STORAGE_DIR}":/storage \
  -v "${LIBS_DIR}":/payara-libs \
  -v "${LOGS_DIR}":/logs \
  payara/micro:5.2021.10-jdk11 \
    --deploymentDir /opt/payara/deployments \
    --addLibs /payara-libs/ \
    --logToFile /logs/payara-server.log

exit 0
