#!/bin/sh

docker run \
  -it \
  --rm \
  -u $(id -u):$(id -g) \
  -v "$(pwd)":/usr/src/myapp \
  -w /usr/src/myapp \
  django_base \
    django-admin startproject mysite


exit 0
