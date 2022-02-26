#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "${SCRIPT_DIR}/../.." && pwd)

DOCKER_NETWORK="webapp-net"

# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z $(docker network ls --filter name="^${DOCKER_NETWORK}$" -q) ]; then
  docker network create "${DOCKER_NETWORK}"
fi

DOCUMENTROOT_DIR=${BASE_DIR}/htdocs
LOGS_DIR=${PARENT_DIR}/logs
CONFIG_DIR=${PARENT_DIR}/config

docker run \
  --name=webapp_websv \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.websv \
  --rm \
  -dit \
  -p 80:80 \
  -v "${DOCUMENTROOT_DIR}":/usr/local/apache2/htdocs \
  -v "${CONFIG_DIR}/my-httpd.conf":/usr/local/apache2/conf/httpd.conf \
  -v "${LOGS_DIR}":/usr/local/apache2/logs/ \
  httpd:2.4

echo "http://localhost:80"


exit 0
