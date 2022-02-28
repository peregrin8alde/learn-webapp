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
mkdir -p ${SCRIPT_DIR}/${APP_NAME}
cd ${SCRIPT_DIR}/${APP_NAME}

npm init -y

# install
npm install --save-dev webpack webpack-cli

npm install bootstrap
npm install @popperjs/core

npm install --save-dev style-loader
npm install --save-dev css-loader

sed -i -e 's/"main": "index.js"/"private": true/g' package.json


exit 0
