#!/bin/sh

docker run \
  -it \
  --rm \
  -p 8000:8000 \
  -v "$(pwd)":/usr/src/myapp \
  -w /usr/src/myapp \
  django_base \
    python manage.py runserver 0:8000


exit 0
