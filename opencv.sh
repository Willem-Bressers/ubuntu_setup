#! /bin/bash

# inspired on https://www.pyimagesearch.com/2018/05/28/ubuntu-18-04-how-to-install-opencv/

version='3.4.1'
root_dir=~/opencv

# =============================================================================
# Step #1: Install OpenCV dependencies on Ubuntu 18.04
# =============================================================================

if [ ! -d $root_dir ]; then

	# ensure the root_dir exist
	mkdir -p $root_dir

	sudo apt update
	sudo apt upgrade -y

	# install developer tools
	sudo apt install -y build-essential cmake pkg-config

	# install some OpenCV-specific prerequisites
	sudo apt install -y libjpeg-dev libpng-dev libtiff-dev

	# You’ll need the following packages so you can work with your camera stream and process video files
	sudo apt install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
	sudo apt install -y libxvidcore-dev libx264-dev

	# install GTK
	sudo apt install -y libgtk-3-dev

	# the following two libraries will optimize various OpenCV functions
	sudo apt install -y libatlas-base-dev gfortran

	# install Python 3 headers and libraries
	sudo apt install -y python3-dev

fi

# =============================================================================
# Step #2: Download the official OpenCV source
# =============================================================================

if [ ! -d $root_dir/opencv-$version ]; then
	wget -O $root_dir/opencv-$version.tar.gz https://github.com/opencv/opencv/archive/$version.tar.gz
	tar -xvzf $root_dir/opencv-$version.tar.gz -C $root_dir
fi

if [ ! -d $root_dir/opencv_contrib-$version ]; then
	wget -O $root_dir/opencv_contrib-$version.tar.gz https://github.com/opencv/opencv_contrib/archive/$version.tar.gz
	tar -xvzf $root_dir/opencv_contrib-$version.tar.gz -C $root_dir
fi

# =============================================================================
# Step #3: Configure your Python 3 environment
# =============================================================================

# install pip
if [ ! -f ~/get-pip.py ]; then
	wget wget -O ~/get-pip.py https://bootstrap.pypa.io/get-pip.py
	sudo python ~/get-pip.py

	# install python libraries
	sudo pip install virtualenv virtualenvwrapper

	# create a virtual environment
	mkvirtualenv cv -p python3

	# update our  ~/.bashrc  file
	echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
	echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
	echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
	echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
	source ~/.bashrc
fi

# ensure we'r working in the cv environment
workon cv

# install python packages for cv environment
pip install numpy

# =============================================================================
# Step #4: Configure and compile OpenCV for Ubuntu 18.04
# =============================================================================

# Configure OpenCV with CMake
if [ ! -d $root_dir/opencv-$version/build ]; then
	mkdir $root_dir/opencv-$version/build
	cd $root_dir/opencv-$version/build
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
		-D CMAKE_INSTALL_PREFIX=/usr/local \
		-D INSTALL_PYTHON_EXAMPLES=ON \
		-D INSTALL_C_EXAMPLES=OFF \
		-D OPENCV_EXTRA_MODULES_PATH=~/opencv/opencv_contrib-3.4.1/modules \
		-D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python \
		-D ENABLE_PRECOMPILED_HEADERS=OFF \
		-D BUILD_EXAMPLES=ON ..
fi 

# Compiling OpenCV on Ubuntu 18.04 (computer has 4 cores)
make -j4

# Installing and verifying OpenCV
sudo make install
sudo ldconfig

# =============================================================================
# Step #5: Finish your Python+ OpenCV + Ubuntu 18.04 install
# =============================================================================

sudo ln -s /usr/local/lib/python3.6/site-packages/cv2.cpython-36m-x86_64-linux-gnu.so /usr/local/lib/python3.6/site-packages/cv2.so
sudo ln -s /usr/local/lib/python3.6/site-packages/cv2.cpython-36m-x86_64-linux-gnu.so $VIRTUAL_ENV/lib/python3.6/site-packages/cv2.so
