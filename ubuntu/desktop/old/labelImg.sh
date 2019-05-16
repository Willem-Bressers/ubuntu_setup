#! /bin/bash

sudo apt install -y python3-pip pyqt5-dev-tools python3-distutils

pip3 install lxml

git clone git@github.com:tzutalin/labelImg.git

cd labelImg

make qt5py3

python3 labelImg.py
