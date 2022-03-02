#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

sh ${PARENT_DIR}/apimng/bin/start.sh
sh ${PARENT_DIR}/appsv/sv/bin/start.sh
sh ${PARENT_DIR}/log/management/agent/bin/start.sh
sh ${PARENT_DIR}/log/management/sv/bin/start.sh
sh ${PARENT_DIR}/storage/db/bin/start.sh
sh ${PARENT_DIR}/usermng/bin/start.sh


exit 0
