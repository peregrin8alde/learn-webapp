#!/bin/sh

docker run \
  -it \
  --rm \
  -u $(id -u):$(id -g) \
  -v "$(pwd)":/usr/src/myapp \
  -w /usr/src/myapp \
  django_base \
    python manage.py startapp polls


exit 0
