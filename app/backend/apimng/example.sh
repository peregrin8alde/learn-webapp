#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)
PARENT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)

curl -X POST \
  -i \
  -H "Content-Type: application/json" \
  --data '{"title":"book01"}' \
  "http://localhost:8000/restapp01/books" | grep "Location: " | sed -E "s|Location: ||g" > .tmp.txt

curl -X GET \
  "http://localhost:8000/restapp01/books" | python -m json.tool

# Location も 自動で書き換えて欲しいため、要調査
CREATED_URL=$(head -n 1 .tmp.txt | sed -e "s|webapp_appsv:8080/restapp01/webapi/resource01|localhost:8000/restapp01|g" | sed -z -e "s/[\r\n]*//g")
echo "${CREATED_URL}"
curl -X GET \
  "${CREATED_URL}" | python -m json.tool

curl -X PUT \
  -H "Content-Type: application/json" \
  --data '{"title":"book001-aaa"}' \
  "${CREATED_URL}"

curl -X DELETE \
  -i \
  "${CREATED_URL}"

rm -rf .tmp.txt


exit 0
