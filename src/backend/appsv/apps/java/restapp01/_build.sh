#!/bin/sh

docker run \
  --rm \
  -it \
  -u 1000:1000 \
  -v "$HOME/.m2":/var/maven/.m2 \
  -v "$PWD:/usr/src/mymaven" \
  -w /usr/src/mymaven \
  -e MAVEN_CONFIG=/var/maven/.m2 \
  maven:3-openjdk-11 \
    mvn clean package \
      -Duser.home=/var/maven

exit 0
