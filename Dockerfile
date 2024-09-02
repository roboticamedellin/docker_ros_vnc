ARG IMAGE="osrf/ros:noetic-desktop-full"

FROM ${IMAGE}

ARG OS
ARG WS_ROS
ENV DEBIAN_FRONTEND=noninteractive
ENV RESOLUTION=1820x880
ENV ROS_DISTRO=noetic
ENV USER=root
ENV WS=/${WS_ROS}
WORKDIR ${WS}

RUN if [ "${OS}" != "linux" ]; then \
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E88979FB9B30ACF2 && \
        apt update -y && \
        apt install wget -y && \
        wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_noetic.sh && \
        wget https://raw.githubusercontent.com/GGomezMorales/robotis_tools/master/sros.sh && \
        chmod +x install_ros_noetic.sh sros.sh && \
        ./install_ros_noetic.sh; \
    fi

RUN apt update && apt install -y \
    python3-catkin-tools \
    python3-rosinstall \
    git \
    nano \
    graphviz \
    iputils-ping \
    net-tools

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source ${WS}/devel/setup.bash" >> ~/.bashrc
RUN echo "alias sros='source /opt/ros/${ROS_DISTRO}/setup.bash ; catkin build ; source ${WS}/devel/setup.bash'" >> ~/.bashrc
