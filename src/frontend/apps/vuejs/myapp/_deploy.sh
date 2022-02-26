#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/../../.." && pwd)

APP_NAME=myapp

DEPLOY_DIR=${BASE_DIR}/deploy

rm -rf ${DEPLOY_DIR}/hdocs/*

cp -rf ${SCRIPT_DIR}/${APP_NAME}/dist/* ${DEPLOY_DIR}/hdocs/


exit 0
