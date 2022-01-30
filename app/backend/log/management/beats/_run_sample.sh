#!/bin/sh

mkdir -p "$PWD/config"
mkdir -p "$PWD/data"

docker run \
  --name=filebeat_sample \
  --hostname filebeat.sample \
  --network logstash_nw \
  -d \
  --rm \
  -v "$PWD/config/":/config:ro \
  -v "$PWD/data/":/data:ro \
  docker.elastic.co/beats/filebeat:7.16.3 \
    filebeat \
    --path.config "/config" \
    -c filebeat-logstash.yml \
    -E 'input.filestream.paths=["/data/input/**/*.log"]' \
    -E "output.logstash.hosts=['logstash:5044']" \
    run


exit 0
