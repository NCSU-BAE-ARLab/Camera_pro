# 1. Install ROS

ROS_VERSION_NAME="kinetic"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt-get update

sudo apt-get -y install ros-kinetic-desktop-full 

sudo rosdep init
rosdep update

echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt -y install python-rosinstall python-rosinstall-generator python-wstool build-essential git cmake cmake-gui libhdf5-openmpi-dev libcgal-qt5-dev python-pip libsdl1.2-dev libsdl-image1.2-dev libserial-dev

# 2. Create a workspace

mkdir -p ~/Projects/ROS/src

cd ~/Projects/ROS
catkin_make

source devel/setup.bash
echo "source ~/Projects/ROS/devel/setup.bash" >> ~/.bashrc

# Download packages
sudo apt -y install ros-${ROS_VERSION_NAME}-ros-control ros-${ROS_VERSION_NAME}-geographic-info ros-${ROS_VERSION_NAME}-navigation ros-${ROS_VERSION_NAME}-libg2o ros-${ROS_VERSION_NAME}-costmap-converter ros-${ROS_VERSION_NAME}-joy ros-${ROS_VERSION_NAME}-twist-mux ros-${ROS_VERSION_NAME}-joint-state-controller ros-${ROS_VERSION_NAME}-controller-manager ros-${ROS_VERSION_NAME}-transmission-interface ros-${ROS_VERSION_NAME}-cmake-modules ros-${ROS_VERSION_NAME}-teb-local-planner ros-${ROS_VERSION_NAME}-camera-info-manager ros-${ROS_VERSION_NAME}-image-geometry ros-${ROS_VERSION_NAME}-gazebo-plugins ros-${ROS_VERSION_NAME}-tf2-eigen ros-${ROS_VERSION_NAME}-pcl-conversions 

# New for noetic
sudo apt -y install ros-${ROS_VERSION_NAME}-ros-controllers

# Before noetic
sudo apt -y upgrade libvtk6-dev
sudo apt -y install ros-${ROS_VERSION_NAME}-serial ros-${ROS_VERSION_NAME}-pr2-controllers ros-${ROS_VERSION_NAME}-interactive-marker-twist-server

# Clone ROS code git
cd src
git clone --recursive https://jygai:Gaijy099@git.ece.iastate.edu/abe-automation-robotic/ros-phenobot.git .

git submodule sync
git submodule update --init

# Install libraries
mkdir -p ~/Projects/dependency
cd ~/Projects/dependency
# Odos
wget -N "http://files.odos-imaging.com/uploads/swift_sdk_v1.5.3.run"
chmod +x swift_sdk_v1.5.3.run
sudo ./swift_sdk_v1.5.3.run

# MSCL IMU
wget -N https://github.com/LORD-MicroStrain/MSCL/releases/download/v48.3.5/python2-mscl_48.3.5_amd64_ubuntu16.04.deb
sudo dpkg -i python2-mscl_48.3.5_amd64_ubuntu16.04.deb
sudo apt install -f
python3 -m pip install pyserial

# SwiftNav GPS
pip install --upgrade pip
git clone https://github.com/swift-nav/libsbp.git
cd libsbp/python
sudo pip install numba future pybase64==0.5
sudo pip install -r requirements.txt
sudo python setup.py install
sudo pip install sbp

# Lucid camera
sudo usermod -a -G dialout $USER

# Create symlinks for IMU and bms ports
sudo touch /etc/udev/rules.d/99-usb-serial.rules
sudo bash -c 'echo "SUBSYSTEM==\"tty\", ATTRS{manufacturer}==\"RoboteQ\", SYMLINK+=\"bms0\"" >> /etc/udev/rules.d/99-usb-serial.rules'sudo gedit /etc/udev/rules.d/99-usb-serial.rules

