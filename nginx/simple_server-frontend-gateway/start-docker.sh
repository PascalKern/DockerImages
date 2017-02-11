#!/usr/bin/env bash

# The base path above the Dockerfile MUST NOT contain any spaces! Else the image get's not build!

# Mapped volumes must not start with ./ or relative! They must be absolute or prefixed with `pwd`


docker build --rm -t nginx:pk .

docker rm nginxPKc

docker run --name nginxPKc \
    -v `pwd`/config/usrShareNginx:/usr/share/nginx \
    -v `pwd`/config/conf.d:/etc/nginx/conf.d \
    -v `pwd`/html:/usr/local/share/nginx/html \
    -p 80:80 \
    nginx:pk