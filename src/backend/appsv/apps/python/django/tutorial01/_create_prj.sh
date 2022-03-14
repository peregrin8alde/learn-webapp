#!/bin/sh

docker run \
  -it \
  --rm \
  -v "$(pwd)":/usr/src/myapp \
  -w /usr/src/myapp \
  django_base \
    django-admin startproject mysite

# root 権限で作成されるため、権限変更
## 本来は Docker イメージ作成時点でユーザーを用意しておきたい
sudo chown -R $(id -u):$(id -g) mysite


exit 0
