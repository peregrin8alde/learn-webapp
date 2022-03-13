#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=${SCRIPT_DIR}/../../../../../..
TARGET_DIR=${BASE_DIR}/deploy/backend/appsv/sv/webapps

echo $(cd "${TARGET_DIR}" && pwd)
mkdir -p ${TARGET_DIR}

rsync -avh ${SCRIPT_DIR}/target/restapp01.war ${TARGET_DIR} --delete


exit 0
