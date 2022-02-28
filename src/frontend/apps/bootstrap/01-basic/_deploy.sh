#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "${SCRIPT_DIR}/../../../../.." && pwd)
TARGET_DIR=${BASE_DIR}/deploy/frontend/sv/htdocs

mkdir -p ${TARGET_DIR}

rsync -avh ${SCRIPT_DIR}/dist/htdocs/ ${TARGET_DIR} --delete


exit 0
