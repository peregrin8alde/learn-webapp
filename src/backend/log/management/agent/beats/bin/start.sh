#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "${SCRIPT_DIR}/../../../../../../.." && pwd)

LOGS_DIR="${PARENT_DIR}/logs"

CONFIG_DIR="${PARENT_DIR}/config"

DOCKER_NETWORK="webapp-net"

# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z "$(docker network ls --filter name="^${DOCKER_NETWORK}$" -q)" ]; then
  docker network create "${DOCKER_NETWORK}"
fi


# WEB サーバー
LOGDIR_WEBSV="${BASE_DIR}/deploy/frontend/sv/httpd/logs"

docker run \
  --name=webapp_filebeat_websv \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.filebeat.websv \
  -u root \
  -d \
  --rm \
  -v "${CONFIG_DIR}":/config:ro \
  -v "${LOGDIR_WEBSV}":/logs:ro \
  docker.elastic.co/beats/filebeat:7.16.3 \
    filebeat \
      --strict.perms=false \
      --path.config "/config" \
      -c filebeat-logstash.yml \
      -E 'input.filestream.paths=["/logs/*_log"]' \
      -E "output.logstash.hosts=['webapp_logstash:5044']" \
      run

# AP サーバー
LOGDIR_APPSV="${BASE_DIR}/deploy/backend/appsv/sv/payara/logs"

docker run \
  --name=webapp_filebeat_appsv \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.filebeat.appsv \
  -u root \
  -d \
  --rm \
  -v "${CONFIG_DIR}":/config:ro \
  -v "${LOGDIR_APPSV}":/logs:ro \
  docker.elastic.co/beats/filebeat:7.16.3 \
    filebeat \
      --strict.perms=false \
      --path.config "/config" \
      -c filebeat-logstash.yml \
      -E 'input.filestream.paths=["/logs/payara-server.log.0"]' \
      -E "output.logstash.hosts=['webapp_logstash:5044']" \
      run

# DB サーバー
LOGDIR_DB="${BASE_DIR}/deploy/backend/storage/db/postgres/logs"

docker run \
  --name=webapp_filebeat_db \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.filebeat.db \
  -u root \
  -d \
  --rm \
  -v "${CONFIG_DIR}":/config:ro \
  -v "${LOGDIR_DB}":/logs:ro \
  docker.elastic.co/beats/filebeat:7.16.3 \
    filebeat \
      --strict.perms=false \
      --path.config "/config" \
      -c filebeat-logstash.yml \
      -E 'input.filestream.paths=["/logs/*"]' \
      -E "output.logstash.hosts=['webapp_logstash:5044']" \
      run


exit 0
