#!/usr/bin/env bash

set -e

# https://github.com/philipz/docker-nginx-inotify
# https://miteshshah.github.io/linux/nginx/auto-reload-nginx/

# Check inotify-tools is installed or not
# dpkg --get-selections | grep -v deinstall | grep inotify-tools &> /dev/null
# if [ $? -ne 0 ]
# then
#         echo "Installing inotify-tools, please wait..."
#         apk add --no-cache inotify-tools
# fi

while true; do
    changes=$(inotifywait --exclude .swp -e close_write -e create -e modify -e delete -e move -r /etc/nginx)
    
    echo Notified about nginx config changes. Changed files: $changes
    
    # Check NGINX Configuration Test
    # Only Reload NGINX If NGINX Configuration Test Pass
    nginx -t
    if [ $? -eq 0 ]
    then
        echo "Reloading Nginx Configuration"
        nginx -s reload
    else
        echo "Changes on configuration are not valide for nginx!"
    fi
    
done
