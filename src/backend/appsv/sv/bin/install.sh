#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

LOGS_DIR="${PARENT_DIR}/logs"

WEBAPPS_DIR="${PARENT_DIR}/webapps"
LIBS_DIR="${PARENT_DIR}/libs"
FILE_STORAGE_DIR="${PARENT_DIR}/storage"

mkdir -p "${LOGS_DIR}"
mkdir -p "${WEBAPPS_DIR}"
mkdir -p "${LIBS_DIR}"
mkdir -p "${FILE_STORAGE_DIR}"

curl -L -o "${LIBS_DIR}/postgresql-42.3.1.jar" https://jdbc.postgresql.org/download/postgresql-42.3.1.jar


exit 0
