#!/usr/bin/env bash

# =============================================================================
# Install dependencies
# =============================================================================

sudo apt update
sudo apt upgrade
sudo apt install -y build-essential cmake pkg-config
sudo apt install -y libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt install -y libxvidcore-dev libx264-dev
sudo apt install -y libgtk-3-dev
sudo apt install -y libatlas-base-dev gfortran
sudo apt install -y python2.7-dev python3.5-dev

# =============================================================================
# Get latest version
# =============================================================================

version='3.4.1'

wget -O ~/Downloads/opencv.tar.gz https://github.com/opencv/opencv/archive/$version.tar.gz
sudo tar -xvzf ~/Downloads/opencv.tar.gz -C /opt/

wget -O ~/Downloads/opencv_contrib.tar.gz https://github.com/opencv/opencv_contrib/archive/$version.tar.gz
sudo tar -xvzf ~/Downloads/opencv_contrib.tar.gz -C /opt/
