ARG IMAGE="osrf/ros:noetic-desktop-full"

FROM ${IMAGE}

ARG OS
ARG WS_ROS
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=noetic
ENV USER=root
ENV WS=/${WS_ROS}
WORKDIR ${WS}

RUN if [ "${OS}" != "linux" ]; then \
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E88979FB9B30ACF2; \
        apt update && \
        apt install wget dirmngr gnupg2 -y && \
        wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_noetic.sh && \
        chmod +x install_ros_noetic.sh && \
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

USER root
ENV RESOLUTION=1820x880

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source ${WS}/devel/setup.bash" >> ~/.bashrc
RUN echo "alias ftimeros='cd ${WS} && rosdep update && rosdep install --from-paths src --ignore-src -r -y'" >> ~/.bashrc
RUN echo "alias sros='source /opt/ros/${ROS_DISTRO}/setup.bash ; source ${WS}/devel/setup.bash'" >> ~/.bashrc
RUN echo "alias bros='cd ${WS} && catkin build'" >> ~/.bashrc

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc
RUN echo "source ${WS}/devel/setup.bash" >> /root/.bashrc
RUN echo "alias ftimeros='cd ${WS} && rosdep update && rosdep install --from-paths src --ignore-src -r -y'" >> /root/.bashrc
RUN echo "alias sros='source /opt/ros/${ROS_DISTRO}/setup.bash ; source ${WS}/devel/setup.bash'" >> /root/.bashrc
RUN echo "alias bros='cd ${WS} && catkin build'" >> /root/.bashrc
