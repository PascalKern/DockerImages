#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# SCRIPT_DIR=$(dirname `which $0`)

source $SCRIPT_DIR/local-config.sh

docker stop $DEV_CONTAINER_NAME 2>/dev/null || true

# Cleanup all configs and more from image!
# rm -rf $SCRIPT_DIR/../../../../Volumes/jenkins/jenkins_as_infrastructureWatcher/var_home/*