# https://illya13.github.io/RL/tutorial/2020/04/26/installing-tensorflow-on-ubuntu-20.html
# ensure gcc >= 8
sudo apt -y install build-essential
sudo apt -y install gcc-8 g++-8 gcc-9 g++-9

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8 --slave /usr/bin/g++ g++ /usr/bin/g++-8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9 --slave /usr/bin/g++ g++ /usr/bin/g++-9

sudo update-alternatives --config gcc

# download nvidia drivers at https://www.nvidia.com/drivers

# install nvidia
# cd ~/Downloads
# sudo bash NVIDIA-Linux-x86_64-440.82.run

# https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-20-04-focal-fossa-linux
sudo ubuntu-drivers autoinstall