#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/../../.." && pwd)

DEPLOY_DIR=${BASE_DIR}/deploy

rm -rf ${DEPLOY_DIR}/hdocs/*

cp -rf hdocs ${DEPLOY_DIR}/


exit 0
