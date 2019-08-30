#!/bin/bash

# This is to demo

node_app=`docker ps -a | grep nodeapp | awk '{print $NF}'`
if [ $node_app=='nodeapp' ]; then
    echo "nodeapp is running, lets delete"
        docker rm -f nodeapp
fi

images=`docker images | grep kammana/nodejenkins | awk '{print $3}'`
docker rmi $images
docker run -d -p 8080:8080 --name nodeapp $1
