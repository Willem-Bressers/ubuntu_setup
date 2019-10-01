# http://wiki.ros.org/melodic/Installation/Ubuntu

# =============================================================================
# Configure your Ubuntu repositories
# =============================================================================
sudo add-apt-repository restricted
sudo add-apt-repository universe
sudo add-apt-repository multiverse


# =============================================================================
# Setup your sources.list
# =============================================================================
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'


# =============================================================================
# Set up your keys
# =============================================================================
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654


# =============================================================================
# Installation
# =============================================================================
sudo apt update
sudo apt install -y ros-melodic-desktop-full


# =============================================================================
# Initialize rosdep
# =============================================================================
sudo rosdep init
rosdep update


# =============================================================================
# Environment setup
# =============================================================================
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc


# http://wiki.ros.org/melodic/Installation/Source

# # =============================================================================
# # Installing bootstrap dependencies
# # =============================================================================
# sudo apt install -y \
# 	python-rosdep \
# 	python-rosinstall-generator \
# 	python-wstool \
# 	python-rosinstall \
# 	build-essential


# # =============================================================================
# # Initializing rosdep
# # =============================================================================
# sudo rosdep init
# rosdep update


# # =============================================================================
# # Create a catkin Workspace
# # =============================================================================
# mkdir ~/ros_catkin_ws
# cd ~/ros_catkin_ws
# rosinstall_generator desktop_full --rosdistro melodic --deps --tar > melodic-desktop-full.rosinstall
# wstool init -j8 src melodic-desktop-full.rosinstall
# # rosinstall_generator robot --rosdistro melodic --deps --tar > melodic-robot.rosinstall
# # wstool init -j8 src melodic-robot.rosinstall



# # =============================================================================
# # Resolving Dependencies
# # =============================================================================
# rosdep install --from-paths src --ignore-src --rosdistro melodic -y


# # =============================================================================
# # Building the catkin Workspace
# # =============================================================================
# ./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
# source ~/ros_catkin_ws/install_isolated/setup.bash




