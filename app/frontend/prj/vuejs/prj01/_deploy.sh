#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

DEPLOY_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/../../../deploy/hdocs" && pwd)

rm -rf ${DEPLOY_DIR}/*

cp -rf hdocs/* ${DEPLOY_DIR}/


exit 0
