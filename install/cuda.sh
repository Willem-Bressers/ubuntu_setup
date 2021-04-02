# source https://towardsdatascience.com/installing-tensorflow-gpu-in-ubuntu-20-04-4ee3ca4cb75d

# install the nvidia-cuda-toolkit
sudo apt install -y nvidia-cuda-toolkit

# select the appropriate additional driver
# 1. goto: software & updates > additional drivers
# 2. select: Using NVIDIA driver metapackage from nvidia-driver-450 (proprietary, tested)
# 3. apply changes

# reboot to load the drivers
reboot

# ensure cuda is installed
nvcc -V
nvidia-smi

# where is cuda installed
whereis cuda

# download cuDnn
# 1. goto: https://developer.nvidia.com/rdp/form/cudnn-download-survey
# 2. login
# 3. click (goto): Download cuDNN v7.6.5 (November 5th, 2019), for CUDA 10.1
# 4. click (download): cuDNN Library for Linux

# extract cuDnn
cd $HOME/Downloads/
tar -xvzf cudnn-10.1-linux-x64-v7.6.5.32.tgz

# copy the files
sudo cp cuda/include/cudnn.h /usr/lib/cuda/include/
sudo cp cuda/lib64/libcudnn* /usr/lib/cuda/lib64/

# fix file permissions
sudo chmod a+r /usr/lib/cuda/include/cudnn.h /usr/lib/cuda/lib64/libcudnn*

# export cuda environment variables
echo -e "\n# CUDA variables" >> $HOME/.zshrc
echo 'export LD_LIBRARY_PATH=/usr/lib/cuda/lib64:$LD_LIBRARY_PATH' >> $HOME/.zshrc
echo 'export LD_LIBRARY_PATH=/usr/lib/cuda/include:$LD_LIBRARY_PATH' >> $HOME/.zshrc

# ensure bash is sourced (with new addtions)
echo -e "\e[31mRun\e[0m source ~/.zshrc"