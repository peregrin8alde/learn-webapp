#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"

if [ -z $(docker network ls | grep -w "${DOCKER_NETWORK}" | awk '{print $2}') ]; then
  docker network create "${DOCKER_NETWORK}"
fi

mkdir -p "$SCRIPT_DIR/pipeline"
mkdir -p "$SCRIPT_DIR/config"
mkdir -p "$SCRIPT_DIR/logs"

docker run \
  --name=webapp_logstash \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.logstash \
  --rm \
  -d \
  -p 5044:5044 \
  -v "$SCRIPT_DIR/pipeline/":/usr/share/logstash/pipeline/ \
  -v "$SCRIPT_DIR/config/":/usr/share/logstash/config/ \
  -v "$SCRIPT_DIR/logs":/logs \
  docker.elastic.co/logstash/logstash:7.16.3


exit 0
