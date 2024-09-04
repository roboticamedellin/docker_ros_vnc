<h1 align = "center">Docker ROS (noetic) VNC</h1>

This repository provides a Dockerised environment for running **ROS Noetic** with customised configurations based on the host operating system.

- On **Linux**, the setup uses the system's **X11 server** to provide seamless graphical application support.
- For **macOS** and **Windows** users, a **VNC server** is used to provide remote access to the ROS environment and its graphical tools, ensuring a consistent and accessible interface across platforms.

## Table of Contents
- [Prerequisites](#prerequisites)
  - [Installing Docker](#installing-docker)
  - [Installing Git](#installing-git)
- [Cloning the Repository](#cloning-the-repository)
  - [Handling Submodules](#handling-submodules)
- [Building Docker Images](#building-docker-images)
  - [Switching Docker Images](#switching-docker-images)
- [Running the Container](#running-the-container)
- [Contributing](#contributing)
- [License](#license)

---

## Prerequisites

Before running the Docker container for **ROS** with **VNC** (on macOS and Windows) or **X11** (on Linux), ensure the following software is installed on your system:

- **Docker**:
    - **Linux:** [Install Docker Engine on Linux](https://docs.docker.com/engine/install/#supported-platforms)
    - **Windows:** [Install Docker Desktop on Windows](https://docs.docker.com/desktop/install/windows-install/)
    - **macOS:** [Install Docker Desktop on macOS](https://docs.docker.com/desktop/install/mac-install/)
    

- **git**:
    - **Linux**: [Install git for Linux](https://git-scm.com/download/linux).
    - **Windows**: [Install git for Windows](https://git-scm.com/download/win).
    - **macOS**: [Install git for macOS](https://git-scm.com/download/mac)

**Verifying Docker and Git installation:**

After installation, you can verify Docker and Git by running the following command in your terminal:

```bash
docker --version
git --version
```

## Getting started

1. **Clone the repository:**
    To get started, clone the repository to your local machine. Since this repository contains submodules, you should clone it with the `--recurse-submodules` flag:
    
    ```bash
    git clone https://github.com/roboticamed/docker_ros_vnc.git
    cd docker_ros_vnc
    ```

2. **Initialize git submodules:**
    If you cloned the repository without using the `--recurse-submodules` flag, you will need to manually initialize and update the submodules. Run the following commands inside the repository's root directory:

    ```bash
    git submodule update --init --recursive
    ```

3. **Build the Docker image:**
    After cloning the repository and initializing the submodules, you can build the Docker image using the provided `Dockerfile`. Run the following command in the project root:
    
    ```bash
    ./scripts/bash.sh
    ```

4. **Run the Docker container:**
    Once the image is built, you can start a container with the following command:

    ```bash
    ./scripts/run.sh
    ```

Browse http://127.0.0.1:6080/