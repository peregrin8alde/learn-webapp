#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

KEY_DIR=${PARENT_DIR}/../../config/key

# function
## id だけを表示
show_id() {
  echo "$1" \
    | python3 -m json.tool \
    | grep '^    "id"' \
    | sed -E 's/.*: "(.*)".*/\1/g'
}


# main
## service
service=$(curl -s -X POST http://localhost:8001/services \
  --data name=resource01-srv \
  --data url='http://webapp_appsv:8080/restapp01/webapi/resource01'
)
echo service : "${service}"

service_id=$(show_id "${service}")
echo service_id : "${service_id}"

## route
route=$(curl -s -X POST http://localhost:8001/services/${service_id}/routes \
  --data 'paths[]=/restapp01' \
  --data name=resource01-route
)
echo route : "${route}"

route_id=$(show_id "${route}")
echo route_id : "${route_id}"

## plugin
plugin=$(curl -s -X POST http://localhost:8001/routes/${route_id}/plugins \
    --data "name=jwt" \
    --data "config.run_on_preflight=false"
)
echo plugin : "${plugin}"

plugin_id=$(show_id "${plugin}")
echo plugin_id : "${plugin_id}"

## consumer
### keycloak
keycloak=$(curl -s -X GET \
  "http://localhost:8001/consumers/keycloak1"
)
echo keycloak : "${keycloak}"

keycloak_id=$(show_id "${keycloak}")
echo keycloak_id : "${keycloak_id}"

if [ -z "${keycloak_id}" ]; then
  keycloak=$(curl -s -X POST \
    --url http://localhost:8001/consumers/ \
    --data "username=keycloak1" \
    --data "custom_id=keycloak_custum1"
  )
  echo keycloak : "${keycloak}"
  
  keycloak_id=$(show_id "${keycloak}")
  echo keycloak_id : "${keycloak_id}"
fi

curl -s -X POST \
  http://localhost:8001/consumers/keycloak_id/jwt \
  -F "algorithm=RS256" \
  -F "rsa_public_key=@${KEY_DIR}/keycloak_myrealm_rs256_pub.pem" \
  -F "key=http://localhost:8080/auth/realms/myrealm"


### anonymous
anonymous=$(curl -s -X GET \
  "http://localhost:8001/consumers/anonymous_users"
)
echo anonymous : "${anonymous}"

anonymous_id=$(show_id "${anonymous}")
echo anonymous_id : "${anonymous_id}"

if [ -z "${anonymous_id}" ]; then
  anonymous=$(curl -s -X POST \
    --url http://localhost:8001/consumers/ \
    --data "username=anonymous_users"
  )
  echo anonymous : "${anonymous}"
  
  anonymous_id=$(show_id "${anonymous}")
echo anonymous_id : "${anonymous_id}"
fi

curl -i -X PATCH \
  --url http://localhost:8001/plugins/${plugin_id} \
  --data "config.anonymous=${anonymous_id}"


exit 0
