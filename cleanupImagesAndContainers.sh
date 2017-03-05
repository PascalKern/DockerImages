#!/usr/bin/env bash

set -e

# Remove all containers:
docker rm -f $(docker ps -aq) 2>/dev/null || true
# docker rm -f $(docker ps -aq) || true

# Remove all images:
docker rmi -f $(docker images -aq) 2>/dev/null || true
# docker rmi -f $(docker images -aq) || true
