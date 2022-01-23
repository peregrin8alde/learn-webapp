#!/bin/sh

docker run \
  --rm \
  -dit \
  --name webapp-websv \
  -p 80:80 \
  -v "$PWD/hdocs":/usr/local/apache2/htdocs/ \
  -v "$PWD/conf/my-httpd.conf":/usr/local/apache2/conf/httpd.conf \
  httpd:2.4

echo "http://localhost:80"


exit 0
