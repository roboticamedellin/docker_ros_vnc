ARG IMAGE="osrf/ros:noetic-desktop-full"
ARG OS="linux"

FROM ${IMAGE}

ARG WS
ENV WS=${WS}
WORKDIR ${WS}

RUN apt update && apt install -y \
    python3-catkin-tools \
    python3-rosinstall \
    git \
    nano \
    graphviz \
    iputils-ping \
    net-tools

RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-teleop-twist-keyboard \
    ros-${ROS_DISTRO}-catkin \
    ros-${ROS_DISTRO}-urdf \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-tf2-tools

RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-navigation \
    ros-${ROS_DISTRO}-slam-gmapping \
    ros-${ROS_DISTRO}-map-server \
    ros-${ROS_DISTRO}-amcl \
    ros-${ROS_DISTRO}-teb-local-planner

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source ${WS}/devel/setup.bash" >> ~/.bashrc
RUN echo "alias sros='source /opt/ros/${ROS_DISTRO}/setup.bash ; catkin build ; source ${WS}/devel/setup.bash'" >> ~/.bashrc
