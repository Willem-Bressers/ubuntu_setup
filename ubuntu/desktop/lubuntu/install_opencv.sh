OPENCV_VERSION="4.1.0"

# =============================================================================
# Required Packages
# =============================================================================
# install packages
sudo apt install -y \
	build-essential \
	cmake \
	git \
	pkg-config \
	libgtk-3-devl \
	libavcodec-dev \
	libavformat-dev \
	libswscale-dev \
	libv4l-dev \
	libxvidcore-dev \
	libx264-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	gfortran \
	openexr \
	libatlas-base-dev \
	python3-dev \
	python3-numpy \
	libtbb2 \
	libtbb-dev \
	libdc1394-22-dev
	
# clean up packages
sudo apt autoremove -y


# =============================================================================
# Getting OpenCV Source Code
# =============================================================================
# download opencv
if [ ! -d /var/tmp/opencv-$OPENCV_VERSION ]; then
	wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.tar.gz -O /var/tmp/opencv.tar.gz && \
	tar xvzf /var/tmp/opencv.tar.gz -C /var/tmp && \
	rm /var/tmp/opencv.tar.gz
fi

# download opencv contrib modules
if [ ! -d /var/tmp/opencv_contrib-$OPENCV_VERSION ]; then
	wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.tar.gz -O /var/tmp/opencv_contrib.tar.gz && \
	tar xvzf /var/tmp/opencv_contrib.tar.gz -C /var/tmp && \
	rm /var/tmp/opencv_contrib.tar.gz
fi


# =============================================================================
# Building OpenCV from Source Using CMake
# =============================================================================
# create a build directory
if [ ! -d /var/tmp/opencv-$OPENCV_VERSION/build ]; then
	mkdir /var/tmp/opencv-$OPENCV_VERSION/build 
fi

# configure the build (multithreaded / optimized / no examples / no docs / no test)
# see: http://amritamaz.net/blog/opencv-config for some good flags tips
if [ ! -f /var/tmp/opencv-$OPENCV_VERSION/build/Makefile ]; then
	cd /var/tmp/opencv-$OPENCV_VERSION/build
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
		-D CMAKE_INSTALL_PREFIX=/usr/local \
		-D OPENCV_EXTRA_MODULES_PATH=/var/tmp/opencv_contrib-$OPENCV_VERSION/modules \
		-D INSTALL_C_EXAMPLES=OFF \
		-D INSTALL_PYTHON_EXAMPLES=OFF \
		-D BUILD_EXAMPLES=OFF \
		-D BUILD_DOCS=OFF \
		-D BUILD_PERF_TESTS=OFF \
		-D BUILD_TESTS=OFF \
		-D WITH_TBB=ON \
		-D WITH_OPENMP=ON \
		-D WITH_IPP=ON \
		-D WITH_NVCUVID=ON \
		-D WITH_CUDA=OFF \
		-D WITH_CSTRIPES=ON \
		-D WITH_OPENCL=ON \
		..
fi

# Compiling OpenCV
if [ -d /var/tmp/opencv-$OPENCV_VERSION/build/bin/ ] && [ -z "$(ls -A /var/tmp/opencv-$OPENCV_VERSION/build/bin/)" ]; then
	cd /var/tmp/opencv-$OPENCV_VERSION/build
	
	# utilizing all processors
	make -j$(nproc)
fi 

# Installing OpenCV
if [ ! -f /usr/local/bin/opencv_version ]; then
	cd /var/tmp/opencv-$OPENCV_VERSION/build
	sudo make install
fi


# =============================================================================
# Cleanup installation
# =============================================================================
if [ -d /var/tmp/opencv-$OPENCV_VERSION/ ]; then
	mv /var/tmp/opencv-$OPENCV_VERSION /var/tmp/opencv-$OPENCV_VERSION-DEPRICATED
fi

if [ -d /var/tmp/opencv_contrib-$OPENCV_VERSION/ ]; then
	mv /var/tmp/opencv_contrib-$OPENCV_VERSION /var/tmp/opencv_contrib-$OPENCV_VERSION-DEPRICATED
fi
