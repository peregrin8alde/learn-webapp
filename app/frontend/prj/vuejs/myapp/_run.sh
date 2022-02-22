#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/../.." && pwd)

APP_NAME=myapp

# npm は Docker コンテナ利用
npm () {
  docker run \
    --rm \
    -u node \
    -it \
    --name ${APP_NAME} \
    -p 3000:3000 \
    -v npm_modules:/usr/local/lib/node_modules \
    -v "$(pwd):$(pwd)" \
    -w $(pwd) \
    node \
      npm "$@"
  
  return 0
}

# run
cd ${SCRIPT_DIR}/${APP_NAME}
npm run dev -- --host 0.0.0.0


exit 0
