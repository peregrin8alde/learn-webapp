#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"

LOGS_DIR="${PARENT_DIR}/logs"

PIPELINE_DIR="${PARENT_DIR}/pipeline"
CONFIG_DIR="${PARENT_DIR}/config"

# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z "$(docker network ls --filter name="^${DOCKER_NETWORK}$" -q)" ]; then
  docker network create "${DOCKER_NETWORK}"
fi

docker run \
  --name=webapp_logstash \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.logstash \
  --rm \
  -d \
  -p 5044:5044 \
  -v "${PIPELINE_DIR}":/usr/share/logstash/pipeline \
  -v "${CONFIG_DIR}":/usr/share/logstash/config \
  -v "${LOGS_DIR}":/logs \
  docker.elastic.co/logstash/logstash:7.16.3


exit 0
