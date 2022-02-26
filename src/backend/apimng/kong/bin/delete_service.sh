#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)


curl -i -X DELETE http://localhost:8001/services/resource01-srv/routes/resource01-route
curl -i -X DELETE http://localhost:8001/services/resource01-srv


exit 0
