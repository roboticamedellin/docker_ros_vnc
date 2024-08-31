#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")"; cd ..; pwd)"
source ${PROJECT_ROOT}/config.sh

cd "$PROJECT_ROOT"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
OS_SIMPLE=${OS:0:1}
ARCH=$(uname -m)

case "${OS_SIMPLE}-${ARCH}" in
    "d-x86_64"|"m-x86_64")
        IMAGE=${VNC_IMAGE}
        ;;
    "d-arm64"|"m-arm64")
        IMAGE=${ARM_IMAGE}
        ;;
    "l-x86_64"|"l-aarch64"|"l-arm64")
        IMAGE=${ROS_IMAGE}
        ;;
    *)
        echo "Unsupported OS or Arch type: ${OS}-${ARCH}"
        exit 1
        ;;
esac

echo "Building for OS: ${OS}, Arch: ${ARCH}, Image: ${IMAGE}"

docker build --build-arg IMAGE=${IMAGE} --build-arg OS=${OS} --build-arg WS_ROS=${WS_ROS} -t ${DOCKER_IMAGE_NAME} .
