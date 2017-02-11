#!/usr/bin/env bash

# If not exist we need the dir bellow
mkdir -p /etc/nginx/conf.d/sites-enabled

# Link all sites which should be avaiable
ln -sf /etc/nginx/conf.d/sites/test.conf /etc/nginx/conf.d/sites-enabled/test.conf
# ln -sf /etc/nginx/conf.d/sites/debug.conf /etc/nginx/conf.d/sites-enabled/debug.conf

# Fire of nginx server
nginx -g 'daemon off;'