#!/bin/sh

IMG_NAME=flask_base

docker rmi ${IMG_NAME}
docker build -t ${IMG_NAME} .

exit 0
