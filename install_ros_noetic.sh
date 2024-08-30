#!/bin/bash
# Apache License 2.0
# Copyright (c) 2020, ROBOTIS CO., LTD.

OS_VERSION=${OS_VERSION:="focal"}
ROS_DISTRO=${ROS_DISTRO:=$1}
WS=${WS:=$2}

sudo apt update -y
sudo apt install -y chrony ntpdate curl build-essential
sudo ntpdate ntp.ubuntu.com

if [ ! -e /etc/apt/sources.list.d/ros-latest.list ]; then
    sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu ${OS_VERSION} main\" > /etc/apt/sources.list.d/ros-latest.list"
fi

roskey=`apt-key list | grep "Open Robotics"`
if [ -z "$roskey" ]; then
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
fi

roskey=`apt-key list | grep "Open Robotics"`
if [ -n "$roskey" ]; then
    echo "[ROS key exists in the list]"
else
    echo "[Failed to receive the ROS key, aborts the installation]"
    exit 0
fi

sudo apt update -y
sudo apt install -y ros-$ROS_DISTRO-desktop-full
sudo apt install -y ros-$ROS_DISTRO-rqt-* ros-$ROS_DISTRO-gazebo-*
source /opt/ros/$ROS_DISTRO/setup.sh
sudo apt install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential git
sudo apt install python3-rosdep
sudo sh -c "rosdep init"
rosdep update
mkdir -p /$WS/src
cd /$WS/src
catkin_init_workspace
cd /$WS
catkin build

sh -c "echo \"export ROS_MASTER_URI=http://localhost:11311\" >> ~/.bashrc"
sh -c "echo \"export ROS_HOSTNAME=localhost\" >> ~/.bashrc"

exit 0
