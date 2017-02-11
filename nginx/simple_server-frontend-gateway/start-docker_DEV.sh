#!/usr/bin/env bash

# The base path above the Dockerfile MUST NOT contain any spaces! Else the image get's not build!

# Mapped volumes must not start with ./ or relative! They must be absolute or prefixed with `pwd`


docker build --rm --no-cache -f Dockerfile_DEV -t nginx-dev:pk .
if [ $? -ne 0 ]; then
    exit $?
fi

# Patch hosts file for experimental server name
hostsFile=/etc/hosts
if ! grep -q debug.imagic.ch "$hostsFile"; then
    echo Tries to patch the hosts file: $hostsFile. Most likely we need root rights.
    echo "
# Host for docker experiment
172.0.0.1   debug.imagic.ch
" >> "$hostsFile" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo COULD NOT PATCH THE HOSTSFILE! PLEASE RERUN THE START SCRIPT AS ROOT!
    fi
fi


# Remove container with this name if still exists. Else can not run the image with the same container name!
docker rm nginxDevPKc 2>/dev/null


# More or less just a configuartion documentation.
# Config which is usually also possible to set with docker-compose.yml!
docker run  --name nginxDevPKc \
    -v `pwd`/config/usrShareNginx:/usr/share/nginx \
    -v `pwd`/config/conf.d:/etc/nginx/conf.d \
    -v `pwd`/html:/usr/local/share/nginx/html \
    -v `pwd`/logs:/var/log/nginx \
    -v `pwd`/scripts/container-internal:/usr/local/bin/scripts \
    -p 80:80 \
    nginx-dev:pk



# Clean up after container is shut down
echo Cleanup stuff
rm -rf `pwd`/config/conf.d/sites-enabled
rm -rf `pwd`/logs