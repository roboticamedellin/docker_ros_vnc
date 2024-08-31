ARG IMAGE="osrf/ros:noetic-desktop-full"
ARG OS="linux"

FROM ${IMAGE}

ARG WS
ENV DEBIAN_FRONTEND=noninteractive
ENV RESOLUTION=1820x880
ENV ROS_DISTRO=noetic
ENV USER=root
ENV WS=/${WS}
WORKDIR ${WS}

COPY /install_ros_noetic.sh /install_ros_noetic.sh
RUN chmod +x /install_ros_noetic.sh
RUN cd / && sed -i 's/\r$//' ./install_ros_noetic.sh && ./install_ros_noetic.sh ${ROS_DISTRO}

RUN apt install -y \
    python3-catkin-tools \
    python3-rosinstall \
    wget \
    curl \
    git \
    nano \
    graphviz \
    iputils-ping \
    net-tools

RUN mkdir -p ${WS}/src && \
    cd ${WS}/src && \
    git clone https://github.com/GGomezMorales/waver.git && \
    cd waver && \
    mv * ${WS}/src/ && \
    cd ${WS}/src && \
    rm -rf waver && \
    cd ${WS} && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc
RUN echo "source ${WS}/devel/setup.bash" >> ~/.bashrc
RUN echo "alias sros='source /opt/ros/${ROS_DISTRO}/setup.bash ; catkin build ; source ${WS}/devel/setup.bash'" >> ~/.bashrc
