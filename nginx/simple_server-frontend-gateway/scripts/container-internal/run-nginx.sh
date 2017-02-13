#!/usr/bin/env bash

echo Running nginx build with configuration script:
echo $(nginx -V)
echo Test nginx configurations:
echo $(nginx -t)

if [ $? -ne 0 ]; then
    echo "Nginx configuration is not valide. Will shut down!"
    exit -1
fi

# If not exist we need the dir bellow
mkdir -p /etc/nginx/conf.d/sites-enabled

# Link all sites which should be avaiable
ln -sf /etc/nginx/conf.d/sites/test.conf /etc/nginx/conf.d/sites-enabled/test.conf
echo "127.0.0.1     debug.imagic.ch" >> /etc/hosts
# ln -sf /etc/nginx/conf.d/sites/debug.conf /etc/nginx/conf.d/sites-enabled/debug.conf

if [[  $MODE -eq Developement ]]; then
    ln -sf /dev/stdout  /var/log/nginx/default.stdout.access.log
    
    echo "Activate nginx config watcher... (seems not yet working with docker!)"
    nginxConfigChangeWatcher.sh &
    
    echo "Start nginx NOT daemonized!"
    # Fire of nginx server in foreground (ie redirect stdout to docker)    
    nginx -g 'daemon off;'
else
    echo "Start nginx in background (daemonized)."
    # Fire of nginx daemonized in background
    nginx
fi