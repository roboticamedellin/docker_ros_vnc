#!/bin/bash

ROS_IMAGE="osrf/ros:noetic-desktop-full"
VNC_IMAGE="dorowu/ubuntu-desktop-lxde-vnc:focal"
ARM_IMAGE="dorowu/ubuntu-desktop-lxde-vnc:focal-arm64"
WS_ROS="catkin_ws"

DOCKER_IMAGE_NAME="ros-image"
CONTAINER_NAME="ros-container"
ROS_NETWORK="host"
