# install git
# sudo apt install git -y
# git config --global user.email "info@willembressers.nl"
# git config --global user.name "Willem Bressers"
# git config --global core.editor "vim"
# git config --global push.default simple
# git config --global core.excludesfile ~/.gitignore_global
# touch ~/.gitignore_global

# # setup ssh
# ssh-keygen -t rsa -b 4096 -C "info@willembressers.nl"
# cat ~/.ssh/id_rsa.pub 

# install opencv
# git clone https://github.com/jayrambhia/Install-OpenCV.git
# cd Install-OpenCV/Ubuntu/ && chmod +x * && ./opencv_latest.sh

# OS dependencies
sudo apt-get install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

# install cuda
cd ~/Desktop/Projects
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
sudo dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
sudo apt-get update
sudo apt-get install cuda

# install opencv
cd ~/Desktop/Projects
wget https://github.com/opencv/opencv/archive/3.3.0.zip
unzip 3.3.0.zip
cd opencv-3.3.0/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j4

# install darknet
cd ~/Desktop/Projects
git clone https://github.com/pjreddie/darknet.git
cd darknet
make
mkdir -p obj
wget https://pjreddie.com/media/files/yolo.weights