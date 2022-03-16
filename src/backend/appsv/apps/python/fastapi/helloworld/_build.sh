#!/bin/sh

IMG_NAME=fastapi_base

docker rmi ${IMG_NAME}
docker build -t ${IMG_NAME} .

exit 0
