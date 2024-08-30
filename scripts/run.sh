#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config.sh

docker run --privileged --rm -it --gpus all \
    --name $CONTAINER_NAME \
    -e DISPLAY \
    -e TERM \
    -e QT_X11_NO_MITSHM=1 \
    -e XAUTHORITY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $XAUTHORITY:$XAUTHORITY \
    --mount type=bind,source=${PROJECT_ROOT},target=/waver_ws/src \
    --net=host \
    -t \
    ${DOCKER_IMAGE_NAME} 
