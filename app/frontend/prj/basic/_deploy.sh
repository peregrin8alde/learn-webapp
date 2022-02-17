#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/../.." && pwd)

rm -rf ${BASE_DIR}/deploy/hdocs/*

cp -rf hdocs/* ${BASE_DIR}/deploy/hdocs/


exit 0
