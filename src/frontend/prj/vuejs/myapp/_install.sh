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
    -v npm_modules:/usr/local/lib/node_modules \
    -v "$(pwd):$(pwd)" \
    -w $(pwd) \
    node \
      npm "$@"
  
  return 0
}

# 初期化
npm create vite@latest ${APP_NAME} -- --template vue

# install
cd ${SCRIPT_DIR}/${APP_NAME}
npm install


exit 0
