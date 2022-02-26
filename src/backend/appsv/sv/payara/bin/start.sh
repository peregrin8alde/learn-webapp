#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"

# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z $(docker network ls --filter name="^${DOCKER_NETWORK}$" -q) ]; then
  docker network create "${DOCKER_NETWORK}"
fi

mkdir -p "$SCRIPT_DIR/webapps"
mkdir -p "$SCRIPT_DIR/config"
mkdir -p "$SCRIPT_DIR/storage"
mkdir -p "$SCRIPT_DIR/libs"
mkdir -p "$SCRIPT_DIR/logs"

docker run \
  --name=webapp_appsv \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.appsv \
  -d \
  --rm \
  -p 6900:6900 \
  -v "$SCRIPT_DIR/webapps":/opt/payara/deployments \
  -v "$SCRIPT_DIR/config":/config \
  -v "$SCRIPT_DIR/storage":/storage \
  -v "$SCRIPT_DIR/libs":/payara-libs \
  -v "$SCRIPT_DIR/logs":/logs \
  payara/micro:5.2021.10-jdk11 \
    --deploymentDir /opt/payara/deployments \
    --addLibs /payara-libs/ \
    --logToFile /logs/payara-server.log

exit 0
