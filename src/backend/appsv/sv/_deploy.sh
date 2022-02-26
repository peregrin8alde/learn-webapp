#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=${SCRIPT_DIR}/../../../..
TARGET_DIR=${BASE_DIR}/deploy/backend/appsv/sv

mkdir -p ${TARGET_DIR}

rsync -avh ${SCRIPT_DIR}/dist/bin ${TARGET_DIR} --delete
rsync -avh ${SCRIPT_DIR}/dist/config ${TARGET_DIR} --delete


exit 0
