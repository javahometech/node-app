#!/bin/bash

# This is to demo

node_app=`docker ps -a | grep dibyoFargateContainer | awk '{print $NF}'`
if [ $node_app=='dibyoFargateContainer' ]; then
    echo "dibyoFargateContainer is running, lets delete"
        docker rm -f dibyoFargateContainer
fi

images=`docker images | grep kammana/nodejenkins | awk '{print $3}'`
docker rmi $images
docker run -d -p 8080:8080 --name dibyoFargateContainer $1
