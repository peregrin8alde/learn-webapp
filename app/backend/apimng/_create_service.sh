#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)


curl -i -X POST http://localhost:8001/services \
  --data name=my-service \
  --data url='http://webapp_appsv:8080/restapp01/webapi/resource01'

curl -i -X POST http://localhost:8001/services/my-service/routes \
  --data 'paths[]=/restapp01' \
  --data name=my-route


exit 0
