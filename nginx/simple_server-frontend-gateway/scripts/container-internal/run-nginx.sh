#!/usr/bin/env bash

. checkMode.sh

# If not exist we need the dir bellow
mkdir -p /etc/nginx/conf.d/sites-enabled

# Link all sites which should be avaiable
ln -sf /etc/nginx/conf.d/sites/test.conf /etc/nginx/conf.d/sites-enabled/test.conf
# ln -sf /etc/nginx/conf.d/sites/debug.conf /etc/nginx/conf.d/sites-enabled/debug.conf

if [[  $MODE -eq Developement ]]; then
    # Fire of nginx server in foreground (ie redirect stdout to docker)
    nginxConfigChangeWatcher.sh &
    nginx -g 'daemon off;'
else
    # Fire of nginx daemonized in background
    nginx
fi