#!/bin/bash

ROS_IMAGE="osrf/ros:noetic-desktop-full"
VNC_IMAGE="dorowu/ubuntu-desktop-lxde-vnc:focal"
ARM_IMAGE="dorowu/ubuntu-desktop-lxde-vnc:focal-arm64"
WS_ROS="catkin_ws"

DIMAGE_NAME="ros-image"
DCONTAINER_NAME="ros-container"
DROS_NETWORK="host"
