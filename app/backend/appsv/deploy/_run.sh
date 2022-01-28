#!/bin/sh

mkdir -p "$PWD/webapps"
mkdir -p "$PWD/config"
mkdir -p "$PWD/storage"
mkdir -p "$PWD/libs"
mkdir -p "$PWD/logs"

docker run \
  -it \
  --rm \
  --name payara \
  -p 8080:8080 \
  -p 6900:6900 \
  -v "$PWD/webapps":/opt/payara/deployments \
  -v "$PWD/config":/config \
  -v "$PWD/storage":/storage \
  -v "$PWD/libs":/payara-libs \
  -v "$PWD/logs":/logs \
  --network postgres_nw \
  payara/micro:5.2021.10-jdk11 \
    --deploymentDir /opt/payara/deployments \
    --addLibs /payara-libs/ \
    --logToFile /logs/payara-server.log


exit 0
