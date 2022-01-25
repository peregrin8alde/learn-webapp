#!/bin/sh

mkdir -p "$PWD/config"
mkdir -p "$PWD/storage"

docker run \
  -it \
  --rm \
  -p 8080:8080 \
  -p 6900:6900 \
  -v "$PWD/target":/opt/payara/deployments \
  -v "$PWD/config":/config \
  -v "$PWD/storage":/storage \
  -v "$PWD/libs":/payara-libs \
  --network postgres_nw \
  payara/micro:5.2021.10-jdk11 \
    --addLibs /payara-libs/ \
    --deploy /opt/payara/deployments/restapp01.war

exit 0
