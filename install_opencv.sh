#! /bin/bash

# =============================================================================
# Ubuntu packages
# =============================================================================
sudo apt install -y build-essential cmake git pkg-config libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev gfortran openexr python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev

# =============================================================================
# Download opencv
# =============================================================================
if [ ! -d ~/opencv_build ]; then
	mkdir ~/opencv_build && cd ~/opencv_build
	git clone https://github.com/opencv/opencv.git
	git clone https://github.com/opencv/opencv_contrib.git
fi

# =============================================================================
# Configure
# =============================================================================
if [ ~/opencv_build/opencv/build ]; then
	rm -rf ~/opencv_build/opencv/build
fi
mkdir ~/opencv_build/opencv/build && cd ~/opencv_build/opencv/build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..

# =============================================================================
# Compile
# =============================================================================
make -j4

# =============================================================================
# Install 
# =============================================================================
sudo make install

# =============================================================================
# Clone .so file to environment
# =============================================================================
sudo ln -s /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /home/willem/.virtualenvs/dfg_bouquet_quality/lib/python3.6/site-packages/cv2.so

# =============================================================================
# verify 
# =============================================================================
echo "===> OPENCV version <==="
pkg-config --modversion opencv

