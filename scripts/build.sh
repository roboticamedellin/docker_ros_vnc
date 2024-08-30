#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config.sh

cd "$PROJECT_ROOT"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

if [ "$OS" == "darwin" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        IMAGE=${VNC_IMAGE}
    elif [ "$ARCH" == "arm64" ]; then
        IMAGE=${MAC_IMAGE}
    else
        echo "Unsupported Arch type: $ARCH"
        exit 1
    fi
elif [ "$OS" == "linux" ]; then
    if [ "$ARCH" == "x86_64" ]; then
        IMAGE=${ROS_IMAGE}
    elif [ "$ARCH" == "aarch64" ]; then
        IMAGE=${ROS_IMAGE}
    elif [ "$ARCH" == "arm64" ]; then
        IMAGE=${MAC_IMAGE}
    else
        echo "Unsupported Arch type: $ARCH"
        exit 1
    fi
elif [ "$(uname -o | tr '[:upper:]' '[:lower:]')" == "msys" ]; then
    OS=$(uname -o | tr '[:upper:]' '[:lower:]')
    if [ "$ARCH" == "x86_64" ]; then
        IMAGE=${VNC_IMAGE}
    elif [ "$ARCH" == "arm64" ]; then
        IMAGE=${MAC_IMAGE}
    else
        echo "Unsupported Arch type: $ARCH"
        exit 1
    fi
else
    echo "Unsupported OS type: $OS"
    exit 1
fi

docker build --build-arg IMAGE=${IMAGE} --build-arg OS=${OS} --build-arg WS=${WS} -t ${DOCKER_IMAGE_NAME} .
