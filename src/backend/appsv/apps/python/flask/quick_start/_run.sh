#!/bin/sh

IMG_NAME=flask_base
FLASK_APP="$1"

docker run \
  -it \
  --rm \
  -u $(id -u):$(id -g) \
  -p 5000:5000 \
  -v "$(pwd)":/usr/src/myapp \
  -w /usr/src/myapp \
  -e FLASK_APP="${FLASK_APP}" \
  ${IMG_NAME} \
    flask run --host=0.0.0.0


exit 0
