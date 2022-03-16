#!/bin/sh

IMG_NAME=flask_base

docker run \
  -it \
  --rm \
  -u $(id -u):$(id -g) \
  -p 5000:5000 \
  ${IMG_NAME}

exit 0
