#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"

if [ -z $(docker network ls | grep -w "${DOCKER_NETWORK}" | awk '{print $2}') ]; then
  docker network create "${DOCKER_NETWORK}"
fi

sudo tee /var/lib/docker/volumes/kong-vol/_data/kong.yml <<'EOF'
_format_version: "2.1"
_transform: true

services:
- name: my-service
  url: http://webapp_appsv:8080/restapp01/webapi/resource01
  routes:
  - name: my-route
    paths:
    - /restapp01

consumers:
- username: my-user
EOF


docker run \
  --name=webapp_apimng \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.apimng \
  -d \
  --rm \
  -v "kong-vol:/usr/local/kong/declarative" \
  -e "KONG_DATABASE=off" \
  -e "KONG_DECLARATIVE_CONFIG=/usr/local/kong/declarative/kong.yml" \
  -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" \
  -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" \
  -e "KONG_PROXY_ERROR_LOG=/dev/stderr" \
  -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" \
  -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" \
  -p 8000:8000 \
  -p 8443:8443 \
  -p 127.0.0.1:8001:8001 \
  -p 127.0.0.1:8444:8444 \
  kong:2.7



exit 0
