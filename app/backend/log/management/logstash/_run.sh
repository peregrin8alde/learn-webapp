#!/bin/sh

mkdir -p "$PWD/logs"

docker run \
  --name logstash \
  --rm \
  -it \
  -v "$PWD/pipeline/":/usr/share/logstash/pipeline/ \
  -v "$PWD/logs":/logs \
  docker.elastic.co/logstash/logstash:7.16.3


exit 0
