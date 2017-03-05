#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# SCRIPT_DIR=$(dirname `which $0`)

source $SCRIPT_DIR/local-config.sh

docker build --rm --no-cache -f Dockerfile_DEV -t $DEV_IMAGE_NAME .
if [ $? -ne 0 ]; then
    exit $?
fi

docker rm $DEV_CONTAINER_NAME 2>/dev/null || true


# Disables unlock jenkins page (not really working!)
# -e JENKINS_OPTS="$JENKINS_OPTS -Djenkins.install.runSetupWizard=false" \
docker run --rm --name $DEV_CONTAINER_NAME \
    -p 8088:8088 \
    -p 50000:50000 \
    -p 9009:9009 \
    -v "$SCRIPT_DIR/../../../../Volumes/jenkins/jenkins_as_infrastructureWatcher/var_home":/var/jenkins_home \
    $DEV_IMAGE_NAME
