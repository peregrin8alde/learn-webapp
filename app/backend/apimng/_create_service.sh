#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)


curl -i -X POST http://localhost:8001/services \
  --data name=resource01-srv \
  --data url='http://webapp_appsv:8080/restapp01/webapi/resource01'

curl -i -X POST http://localhost:8001/services/resource01-srv/routes \
  --data 'paths[]=/restapp01' \
  --data name=resource01-route

curl -X POST http://localhost:8001/routes/resource01-route/plugins \
    --data "name=jwt" \
    --data "config.run_on_preflight=false"

curl -i -X POST http://localhost:8001/consumers \
    --data "username=keycloak1" \
    --data "custom_id=keycloak_custum1"

curl -i -X POST http://localhost:8001/consumers/keycloak1/jwt \
    -F "algorithm=RS256" \
    -F "rsa_public_key=@${SCRIPT_DIR}/keys/keycloak_myrealm_rs256_pub.pem" \
    -F "key=http://localhost:8080/auth/realms/myrealm"


exit 0
