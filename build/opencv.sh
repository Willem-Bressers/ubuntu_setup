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
	libgtk-3-dev \
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
# download opencv + opencv contrib modules
if [ ! -f /var/tmp/opencv.tar.gz ]; then
	wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.tar.gz -O /var/tmp/opencv.tar.gz
fi
if [ ! -f /var/tmp/opencv_contrib.tar.gz ]; then
	wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.tar.gz -O /var/tmp/opencv_contrib.tar.gz
fi

# unzip tar files
if [ -f /var/tmp/opencv.tar.gz ] && [ ! -d /var/tmp/opencv-$OPENCV_VERSION ]; then
	tar xvzf /var/tmp/opencv.tar.gz -C /var/tmp
fi
if [ -f /var/tmp/opencv_contrib.tar.gz ] && [ ! -d /var/tmp/opencv_contrib-$OPENCV_VERSION ]; then
	tar xvzf /var/tmp/opencv_contrib.tar.gz -C /var/tmp 
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
	rm /var/tmp/opencv.tar.gz
	rm -rf /var/tmp/opencv-$OPENCV_VERSION
fi

if [ -d /var/tmp/opencv_contrib-$OPENCV_VERSION/ ]; then
	rm /var/tmp/opencv_contrib.tar.gz
	rm -rf /var/tmp/opencv_contrib-$OPENCV_VERSION
fi

# =============================================================================
# Add opencv to user python location
# =============================================================================
sudo ln -s /usr/local/lib/python3.8/dist-packages/cv2/python-3.8/cv2.cpython-38-x86_64-linux-gnu.so `python3 -m site --user-site`/cv2.so

# python 3.6
# /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so

# python 3.7
# /usr/local/lib/python3.7/dist-packages/cv2/python-3.7/cv2.cpython-37m-x86_64-linux-gnu.so

# # sudo ln -s /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /home/willem/.virtualenvs/dfg_bouquet_quality/lib/python3.6/site-packages/cv2.so
# sudo ln -s /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /home/willem/.virtualenvs/dfg_bouquet_quality/lib/python3.6/site-packages/cv2.so
# sudo ln -s /usr/local/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /home/willem/.virtualenvs/object-detection-flowers/lib/python3.6/site-packages/cv2.so