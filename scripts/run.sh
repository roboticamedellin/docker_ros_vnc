#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config.sh

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
OS_SIMPLE=${OS:0:1}

if [ "$OS_SIMPLE" == "d" ] || [ "$OS_SIMPLE" == "m" ]; then
    #missing line: --mount ${PROJECT_ROOT}/${WS_ROS}:/${WS_ROS}
    docker run -it --rm \
        -v ${PROJECT_ROOT}/${WS_ROS}:/${WS_ROS} \
        --name $CONTAINER_NAME \
        -p 6080:80 \
        -p 5900:5900 \
        --rm ${DOCKER_IMAGE_NAME}
else
    docker run --privileged --rm -it --gpus all \
        --name $CONTAINER_NAME \
        -v ${PROJECT_ROOT}/${WS_ROS}:/${WS_ROS} \
        -e DISPLAY \
        -e TERM \
        -e QT_X11_NO_MITSHM=1 \
        -e XAUTHORITY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $XAUTHORITY:$XAUTHORITY \
        --net=host \
        -t \
        --rm ${DOCKER_IMAGE_NAME} 
fi
