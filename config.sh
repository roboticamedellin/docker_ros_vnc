#!/bin/bash

ROS_IMAGE="osrf/ros:noetic-desktop-full"
VNC_IMAGE="dorowu/ubuntu-desktop-lxde-vnc:focal"
MAC_IMAGE="dorowu/ubuntu-desktop-lxde-vnc:focal-arm64"
WS="catkin_ws"

DOCKER_IMAGE_NAME="ros-image"
CONTAINER_NAME="ros-container"
ROS_NETWORK="host"
