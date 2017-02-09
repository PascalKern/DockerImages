#!/usr/bin/env bash

docker-machine start

eval $("E:\programs\Docker\Docker Toolbox\docker-machine.exe" env)

docker build -t nn "E:\projects\Docker\DockerImages\nodejs-nginx"

docker run --name NNc --rm -i -p 80:80 -p 443:443 nn 
