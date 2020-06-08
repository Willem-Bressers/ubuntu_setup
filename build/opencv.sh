# https://docs.opencv.org/4.3.0/d2/de6/tutorial_py_setup_in_ubuntu.html
# https://docs.opencv.org/4.3.0/d7/d9f/tutorial_linux_install.html
sudo apt-get install -y \
	build-essential \
	cmake \
	doxygen \
	g++ \
	gcc \
	gfortran \
	git \
	libatlas-base-dev \
	libavcodec-dev \
	libavformat-dev \
	libavresample-dev \
	libdc1394-22-dev \
	libeigen3-dev \
	libfaac-dev \
	libgflags-dev \
	libgoogle-glog-dev \
	libgphoto2-dev \
	libgstreamer-plugins-base1.0-dev \
	libgstreamer1.0-dev \
	libgtk-3-dev \
	libhdf5-dev \
	libjpeg-dev \
	libmp3lame-dev \
	libopencore-amrnb-dev \
	libopencore-amrwb-dev \
	libopenexr-dev \
	libpng-dev \
	libprotobuf-dev \
	libswscale-dev \
	libtbb-dev \
	libtheora-dev \
	libtiff-dev \
	libvorbis-dev \
	libwebp-dev \
	libx264-dev \
	libxvidcore-dev \
	pkg-config \
	protobuf-compiler \
	python3-dev \
	python3-numpy \
	x264

cd ~
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

cd ~/opencv
mkdir build
cd build

