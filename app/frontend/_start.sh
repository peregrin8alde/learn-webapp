#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"

if [ -z $(docker network ls | grep -w "${DOCKER_NETWORK}" | awk '{print $2}') ]; then
  docker network create "${DOCKER_NETWORK}"
fi

mkdir -p "$SCRIPT_DIR/logs"

docker run \
  --name=webapp_websv \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.websv \
  --rm \
  -dit \
  -p 80:80 \
  -v "$SCRIPT_DIR/hdocs":/usr/local/apache2/htdocs/ \
  -v "$SCRIPT_DIR/conf/my-httpd.conf":/usr/local/apache2/conf/httpd.conf \
  -v "$SCRIPT_DIR/logs":/usr/local/apache2/logs/ \
  httpd:2.4

echo "http://localhost:80"


exit 0
