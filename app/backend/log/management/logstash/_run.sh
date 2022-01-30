#!/bin/sh

mkdir -p "$PWD/pipeline"
mkdir -p "$PWD/config"
mkdir -p "$PWD/logs"

docker run \
  --name logstash \
  --hostname logstash.sv \
  --rm \
  -it \
  -p 5044:5044 \
  -v "$PWD/pipeline/":/usr/share/logstash/pipeline/ \
  -v "$PWD/config/":/usr/share/logstash/config/ \
  -v "$PWD/logs":/logs \
  docker.elastic.co/logstash/logstash:7.16.3


exit 0
