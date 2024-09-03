#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config.sh

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
OS_SIMPLE=${OS:0:1}

if [ "$OS_SIMPLE" == "d" ] || [ "$OS_SIMPLE" == "m" ]; then
    docker run -it --rm \
        --name $DCONTAINER_NAME \
        -v ${PROJECT_ROOT}/${WS_ROS}:/${WS_ROS} \
        -p 6080:80 \
        -p 5900:5900 \
        --net=${DROS_NETWORK} \
        --rm ${DIMAGE_NAME}
else
    docker run --privileged --rm -it --gpus all \
        --name $DCONTAINER_NAME \
        -v ${PROJECT_ROOT}/${WS_ROS}:/${WS_ROS} \
        -e DISPLAY \
        -e TERM \
        -e QT_X11_NO_MITSHM=1 \
        -e XAUTHORITY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $XAUTHORITY:$XAUTHORITY \
        --net=${DROS_NETWORK} \
        -t \
        --rm ${DIMAGE_NAME} 
fi
