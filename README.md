<h1 align = "center">Docker ROS (noetic) VNC</h1>

This repository provides a Dockerised environment for running **ROS Noetic** with customised configurations based on the host operating system.

- On **Linux**, the setup uses the system's **X11 server** to provide seamless graphical application support.
- For **macOS** and **Windows** users, a **VNC server** is used to provide remote access to the ROS environment and its graphical tools, ensuring a consistent and accessible interface across platforms.

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
    ./scripts/build.sh
    ```

4. **Run the Docker container:**
    Once the image is built, you can start a container with the following command:

    ```bash
    ./scripts/run.sh
    ```

## Accessing the Docker container

Depending on your operating system, you can access the Docker container as follows:

- **For Linux:**  
  The terminal is directly accessible when you run the `./scripts/run.sh` file, providing seamless interaction with the container.

- **For macOS or Windows:**  
  You can access the container using **noVNC** through your browser. After running the container, open the following link in your browser:

  [http://127.0.0.1:6080/](http://127.0.0.1:6080/)
  
  to access the ROS environment with a graphical interface.

## License
MIT

## Authors
[Gustavo Gomez Morales](https://www.linkedin.com/in/ggomezmorales/)
[Alejandro Gomez Flórez](https://www.linkedin.com/in/aldajo92)
[Juan Manuel Gomez Vásquez](https://www.linkedin.com/in/juan-manuel-g%C3%B3mez-v%C3%A1squez-97366a171/)
