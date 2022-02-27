#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

CONFIG_DIR="${PARENT_DIR}/config"

DOCKER_NETWORK="webapp-net"

# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z "$(docker network ls --filter name="^${DOCKER_NETWORK}$" -q)" ]; then
  docker network create "${DOCKER_NETWORK}"
fi

mkdir -p "${PARENT_DIR}/data"

docker run \
  --name=filebeat_sample \
  --network "${DOCKER_NETWORK}" \
  --hostname filebeat.sample \
  -u root \
  -d \
  --rm \
  -v "${CONFIG_DIR}":/config:ro \
  -v "${PARENT_DIR}/data/":/data:ro \
  docker.elastic.co/beats/filebeat:7.16.3 \
    filebeat \
      --strict.perms=false \
      --path.config "/config" \
      -c filebeat-logstash.yml \
      -E 'input.filestream.paths=["/data/input/**/*.log"]' \
      -E "output.logstash.hosts=['webapp_logstash:5044']" \
      run

mkdir -p "${PARENT_DIR}/data/input/type1"
echo "type1-aaa" >> "${PARENT_DIR}/data/input/type1/data01.log"

mkdir -p "${PARENT_DIR}/data/input/type2"
echo "type2-aaa" >> "${PARENT_DIR}/data/input/type2/data01.log"

sleep 10

docker stop filebeat_sample

exit 0
