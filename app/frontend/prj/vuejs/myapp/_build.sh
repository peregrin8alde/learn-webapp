#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/../.." && pwd)

APP_NAME=myapp

# vite は Docker コンテナ利用
vite () {
  docker run \
    --rm \
    -u node \
    -v npm_modules:/usr/local/lib/node_modules \
    -v "$(pwd):$(pwd)" \
    -w $(pwd) \
    node \
      npx vite "$@"
  
  return 0
}

cd ${SCRIPT_DIR}/${APP_NAME}

vite build


exit 0
