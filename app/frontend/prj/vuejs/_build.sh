#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

# npx は Docker コンテナ利用
npx () {
  docker run \
    --rm \
    -v npm_modules:/usr/local/lib/node_modules \
    -v "$(pwd):$(pwd)" \
    -w $(pwd) \
    node \
      npx "$@"
  
  return 0
}

# production にしないとビルド時点で警告発生
npx webpack --mode=production


exit 0
