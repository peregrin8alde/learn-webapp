#!/bin/sh

IMG_NAME=fastapi_base

docker run \
  -it \
  --rm \
  -u $(id -u):$(id -g) \
  -p 8000:8000 \
  ${IMG_NAME} \
    uvicorn main:app --reload --host 0.0.0.0


exit 0
