# http://wiki.ros.org/ROS/Tutorials/InstallingandConfiguringROSEnvironment

# ensure that source /opt/ros/melodic/setup.bash is sourced
source ~/.bashrc

# =============================================================================
# Create a ROS Workspace
# =============================================================================
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
source devel/setup.bash