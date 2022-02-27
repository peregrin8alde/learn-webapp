#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

LOGS_DIR="${PARENT_DIR}/logs"

PIPELINE_DIR="${PARENT_DIR}/pipeline"
CONFIG_DIR="${PARENT_DIR}/config"

mkdir -p "${LOGS_DIR}"
mkdir -p "${PIPELINE_DIR}"
mkdir -p "${CONFIG_DIR}"


exit 0
