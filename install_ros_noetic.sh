#!/bin/bash
# Apache License 2.0
# Copyright (c) 2020, ROBOTIS CO., LTD.

echo ""
echo "[Note] Target OS version  >>> Ubuntu 20.04.x (Focal Fossa) or Linux Mint 21.x"
echo "[Note] Target ROS version >>> ROS Noetic Ninjemys"
echo "[Note] Catkin workspace   >>> /$2"
echo ""
read

echo "[Set the target OS, ROS version and name of catkin workspace]"
OS_VERSION=${OS_VERSION:="focal"}
ROS_DISTRO=${ROS_DISTRO:=$1}
WS_ROS=${WS_ROS:=$2}

echo "[Update the package lists]"
sudo apt update -y

echo "[Install build environment, the chrony, ntpdate and set the ntpdate]"
sudo apt install -y chrony ntpdate curl build-essential
sudo ntpdate ntp.ubuntu.com

echo "[Add the ROS repository]"
if [ ! -e /etc/apt/sources.list.d/ros-latest.list ]; then
  sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu ${OS_VERSION} main\" > /etc/apt/sources.list.d/ros-latest.list"
fi

echo "[Download the ROS keys]"
roskey=apt-key list | grep "Open Robotics"
if [ -z "$roskey" ]; then
  curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
fi

echo "[Check the ROS keys]"
roskey=apt-key list | grep "Open Robotics"
if [ -n "$roskey" ]; then
  echo "[ROS key exists in the list]"
else
  echo "[Failed to receive the ROS key, aborts the installation]"
  exit 0
fi

echo "[Update the package lists]"
sudo apt update -y

echo "[Install ros-desktop-full version of Noetic"
sudo apt install -y ros-$ROS_DISTRO-desktop-full

echo "[Install RQT & Gazebo]"
sudo apt install -y ros-$ROS_DISTRO-rqt-* ros-$ROS_DISTRO-gazebo-*

echo "[Environment setup and getting rosinstall]"
source /opt/ros/$ROS_DISTRO/setup.sh
sudo apt install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential git

echo "[Install rosdep and Update]"
sudo apt install python3-rosdep

echo "[Initialize rosdep and Update]"
sudo sh -c "rosdep init"
rosdep update

echo "[Make the catkin workspace and test the catkin_make]"
mkdir -p /$WS_ROS/src
cd /$WS_ROS/src
catkin_init_workspace
cd /$WS_ROS
catkin_make

echo "[Set the ROS evironment]"
sh -c "echo \"alias eb='nano ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias sb='source ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias gs='git status'\" >> ~/.bashrc"
sh -c "echo \"alias gp='git pull'\" >> ~/.bashrc"
sh -c "echo \"alias cw='cd /$WS_ROS'\" >> ~/.bashrc"
sh -c "echo \"alias cs='cd /$WS_ROS/src'\" >> ~/.bashrc"
sh -c "echo \"alias cm='cd /$WS_ROS && catkin_make'\" >> ~/.bashrc"
sh -c "echo \"alias sros='cd /$WS_ROS && /opt/ros/${ROS_DISTRO}/setup.bash && catkin build && source ${WS}/devel/setup.bash'\" >> ~/.bashrc"

sh -c "echo \"source /opt/ros/$ROS_DISTRO/setup.bash\" >> ~/.bashrc"
sh -c "echo \"source /$WS_ROS/devel/setup.bash\" >> ~/.bashrc"

sh -c "echo \"export ROS_MASTER_URI=http://localhost:11311\" >> ~/.bashrc"
sh -c "echo \"export ROS_HOSTNAME=localhost\" >> ~/.bashrc"

source ~/.bashrc

echo "[Complete!!!]"
exit 0
