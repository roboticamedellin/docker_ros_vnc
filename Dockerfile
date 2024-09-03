ARG IMAGE="osrf/ros:noetic-desktop-full"

FROM ${IMAGE}

ARG OS
ARG WS_ROS
ENV DEBIAN_FRONTEND=noninteractive
ENV RESOLUTION=1820x880
ENV ROS_DISTRO=noetic
WORKDIR ${WS}

RUN if [ "${OS}" != "linux" ]; then \
        apt update && \
        apt install wget -y && \
        wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_noetic.sh && \
        chmod +x install_ros_noetic.sh && \
        ./install_ros_noetic.sh; \
    fi

RUN if [ "${OS}" != "linux" ]; then \
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E88979FB9B30ACF2; \
    fi

RUN apt update && apt install -y \
    python3-catkin-tools \
    python3-rosinstall \
    wget \
    curl \
    git \
    nano \
    graphviz \
    iputils-ping \
    net-tools

RUN echo "alias ftimeros='cd /${WS_ROS} && rosdep update && rosdep install --from-paths src --ignore-src -r -y'" >> ~/.bashrc
RUN echo "alias bros='catkin build'" >> ~/.bashrc
RUN echo "alias sros='source /opt/ros/${ROS_DISTRO}/setup.bash ; source /${WS_ROS}/devel/setup.bash'" >> ~/.bashrc
