#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

LOGS_DIR="${PARENT_DIR}/logs"
DATA_DIR="${PARENT_DIR}/data"

mkdir -p "${LOGS_DIR}"
mkdir -p "${DATA_DIR}"


exit 0
