#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/../.." && pwd)

APP_NAME=myapp

TARGET_DIR=${SCRIPT_DIR}/${APP_NAME}/dist

# npx は Docker コンテナ利用
npx () {
  docker run \
    --rm \
    -u node \
    -v npm_modules:/usr/local/lib/node_modules \
    -v "$(pwd):$(pwd)" \
    -w $(pwd) \
    node \
      npx "$@"
  
  return 0
}

cd ${SCRIPT_DIR}/${APP_NAME}

# production にしないとビルド時点で警告発生
npx webpack --mode=production

# dist/index.html ではなく src/index.html として管理したいのでビルド時にコピー
## ちゃんとやるなら html-webpack-plugin などを使う
rsync -avh ${SCRIPT_DIR}/${APP_NAME}/src/index.html ${TARGET_DIR} --exclude "*.gitkeep" --delete



exit 0
