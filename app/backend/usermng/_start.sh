#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DOCKER_NETWORK="webapp-net"

# --filter は golang の正規表現でフィルタ、 -q は id だけ表示
if [ -z $(docker network ls --filter name="^${DOCKER_NETWORK}$" -q) ]; then
  docker network create "${DOCKER_NETWORK}"
fi

if [ -z $(docker container ls --filter name="^webapp_apimng_database$" -q) ]; then
  docker start webapp_apimng_database
fi

# DB として h2 を使った場合に /opt/jboss/keycloak/standalone/data をマウント 
mkdir -p "$SCRIPT_DIR/data"

docker run \
  --name=webapp_usermng \
  --network "${DOCKER_NETWORK}" \
  --hostname webapp.usermng \
  -it \
  -d \
  --rm \
  -p 8080:8080 \
  -v "$SCRIPT_DIR/data":/opt/jboss/keycloak/standalone/data \
  -e KEYCLOAK_USER=admin \
  -e KEYCLOAK_PASSWORD=admin \
  jboss/keycloak:16.1.1


echo "http://localhost:8080/auth/admin"


exit 0
