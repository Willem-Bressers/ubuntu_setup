# https://linuxize.com/post/how-to-install-opencv-on-ubuntu-20-04/

# =============================================================================
# Required Packages
# =============================================================================
# update packages
sudo apt-get update 

# install packages
sudo apt-get install -y build-essential cmake git pkg-config libgtk-3-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev gfortran openexr libatlas-base-dev python3-dev libtbb2 libtbb-dev libdc1394-22-dev 
	
# clean up packages
sudo apt autoremove -y

# ensure python is globally installed
pip3 install numpy 


# =============================================================================
# Getting OpenCV Source Code
# =============================================================================
# download opencv + opencv contrib modules
if [ ! -d ~/opencv_build/opencv ]; then
	mkdir ~/opencv_build
	git clone https://github.com/opencv/opencv.git ~/opencv_build/opencv 
fi
if [ ! -d ~/opencv_build/opencv_contrib ]; then
	git clone https://github.com/opencv/opencv_contrib.git ~/opencv_build/opencv_contrib 
fi


# =============================================================================
# Building OpenCV from Source Using CMake
# =============================================================================
# create a build directory
if [ ! -d ~/opencv_build/opencv/build ]; then
	mkdir ~/opencv_build/opencv/build
fi


# configure the build (multithreaded / optimized / no examples / no docs / no test)
# see: http://amritamaz.net/blog/opencv-config for some good flags tips
if [ ! -f ~/opencv_build/opencv/build/Makefile ]; then
	cd ~/opencv_build/opencv/build
	# http://amritamaz.net/blog/opencv-config#3-i-want-my-compile-to-be-fast-and-my-code-to-be-speedy
	cmake \
		-D CMAKE_INSTALL_PREFIX=/usr/local \
		-D INSTALL_C_EXAMPLES=ON \
		-D INSTALL_PYTHON_EXAMPLES=ON \
		-D OPENCV_GENERATE_PKGCONFIG=ON \
		-D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
		-D BUILD_NEW_PYTHON_SUPPORT=ON \
		-D BUILD_opencv_python3=yes \
		-D HAVE_opencv_python3=ON \
		-D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
		-D WITH_TBB=ON \
		-D WITH_OPENMP=ON \
		-D WITH_IPP=ON \
		-D CMAKE_BUILD_TYPE=RELEASE \
		-D BUILD_EXAMPLES=OFF \
		-D WITH_NVCUVID=ON \
		-D WITH_CUDA=ON \
		-D BUILD_DOCS=OFF \
		-D BUILD_PERF_TESTS=OFF \
		-D BUILD_TESTS=OFF \
		-D WITH_CSTRIPES=ON \
		-D WITH_OPENCL=ON CMAKE_INSTALL_PREFIX=/usr/local/ \
		.. 
fi

# Compiling OpenCV
if [ -d ~/opencv_build/opencv/build/bin/ ] && [ -z "$(ls -A ~/opencv_build/opencv/build/bin/)" ]; then
	cd ~/opencv_build/opencv/build
	
	# utilizing all processors
	make -j$(nproc)
fi 

# Installing OpenCV
if [ ! -f /usr/local/bin/opencv_version ]; then
	cd ~/opencv_build/opencv/build
	sudo make install
fi

# =============================================================================
# Checks
# =============================================================================
# C++ bindings
CCHECK=$(pkg-config --modversion opencv4)
echo -e "\e[31mC++ version check:\e[0m $CCHECK"

# python check
PYTHONCHECK=$(python3 -c "import cv2; print(cv2.__version__)")
echo -e "\e[31mPython3 version check:\e[0m $PYTHONCHECK"


# =============================================================================
# Inherit global packages in your new environment
# =============================================================================
echo -e "\e[31mCreate a new virtual environment like so:\e[0m mkvirtualenv --system-site-packages my-env-name"

# =============================================================================
# Add opencv to virtual environment
# =============================================================================
# sudo ln -s /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /home/willem/.virtualenvs/dfg_bouquet_quality/lib/python3.6/site-packages/cv2.so
# sudo ln -s /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /home/willem/.virtualenvs/dfg_bouquet_quality/lib/python3.6/site-packages/cv2.so
# sudo ln -s /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /home/willem/.virtualenvs/object-detection-flowers/lib/python3.6/site-packages/cv2.so
