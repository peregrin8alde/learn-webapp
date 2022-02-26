#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=${PARENT_DIR}

mkdir -p ${BASE_DIR}/deploy

rsync -avh ${SCRIPT_DIR}/dist/bin ${BASE_DIR}/deploy/ --delete
rsync -avh ${SCRIPT_DIR}/dist/config ${BASE_DIR}/deploy/ --delete


exit 0
