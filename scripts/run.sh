#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config.sh

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
OS_SIMPLE=${OS:0:1}

if [ "$OS_SIMPLE" == "d" ] || [ "$OS_SIMPLE" == "m" ]; then
    docker run -it --rm \
        --name ${DCONTAINER_NAME} \
        -p 6080:80 \
        --mount type=bind,source=${PROJECT_ROOT}/${WS_ROS}/,target=/${WS_ROS}/ \
        ${DIMAGE_NAME}
else
    docker run --privileged --rm -it --gpus all \
        --name ${DCONTAINER_NAME} \
        -e DISPLAY \
        -e TERM \
        -e QT_X11_NO_MITSHM=1 \
        -e XAUTHORITY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $XAUTHORITY:$XAUTHORITY \
        -v ${PROJECT_ROOT}/${WS_ROS}:/${WS_ROS} \
        --net=${DROS_NETWORK} \
        -t \
        ${DIMAGE_NAME}
fi
