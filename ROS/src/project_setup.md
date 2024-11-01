# System Configuration for PhenoBot 3.0
This file details all the necessary procedures for setting up the environment for running and developing PhenoBot 3.0.

Drafted on 11/31/2021

## Steps: 
### 1. Install ROS
Before installing ROS, install some necessary packages
```
    sudo apt -y install python-wstool build-essential git cmake cmake-gui libhdf5-openmpi-dev libcgal-qt5-dev python-pip libsdl1.2-dev libsdl-image1.2-dev libserial-dev libopencv-dev
```

Please follow the introduction from ROS official website (http://wiki.ros.org/noetic/Installation/Ubuntu) to install the desktop full version. 

Current version: noetic

e.g. Turn on the terminal in linux (CTRL+ALT+T), paste the following lines, press enter.

```
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```
If in China, the sources server in the US is not accessable. Use Chinese server instead. 
```
    sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ `lsb_release -cs` main" > /etc/apt/sources.list.d/ros-latest.list'
```
If in China, the installation might be stuck at `rosdep init`, there isn't a solution yet. Actually, it dosen't matter that much.

After installing ROS, there are some additional packages to install
```
    ROS_VERSION_NAME="noetic"
    sudo apt -y upgrade libvtk6-dev
    sudo apt -y install ros-${ROS_VERSION_NAME}-pr2-controllers ros-${ROS_VERSION_NAME}-interactive-marker-twist-server
```
Some package to delete, since they were modified for this application.
```
    sudo apt -y remove ros-${ROS_VERSION_NAME}-robot_localization ros-${ROS_VERSION_NAME}-teb-local-planner
```
### 2. Create a workspace
```
# Create a workspace to store the code, builded excutive programs etc. 
mkdir -p ~/Projects/ROS/src
cd ~/Projects/ROS/src

# Copy the source code, or clone the code git to the src folder
git clone --recursive https://jygai:Gaijy099@git.ece.iastate.edu/abe-automation-robotic/ros-phenobot.git
# Need to enter the username and the password

# Initial build
cd ~/Projects/ROS
catkin_make

source devel/setup.bash
echo "source ~/Projects/ROS/devel/setup.bash" >> ~/.bashrc
```

### 3. Install libraries