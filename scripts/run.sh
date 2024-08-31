#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config.sh

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
if [ "$OS" == "darwin" ] || [ "$(uname -o | tr '[:upper:]' '[:lower:]')" == "msys" ]; then
    docker run -it --rm \
        --name $CONTAINER_NAME \
        -p 6080:80 \
        ${DOCKER_IMAGE_NAME}
else
    docker run --privileged --rm -it --gpus all \
        --name $CONTAINER_NAME \
        -e DISPLAY \
        -e TERM \
        -e QT_X11_NO_MITSHM=1 \
        -e XAUTHORITY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $XAUTHORITY:$XAUTHORITY \
        --net=host \
        -t \
        ${DOCKER_IMAGE_NAME} 
fi
