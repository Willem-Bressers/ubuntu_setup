# # https://medium.com/@aspiring1/installing-cuda-toolkit-10-0-and-cudnn-for-deep-learning-with-tensorflow-gpu-on-ubuntu-18-04-lts-f7e968b24c98

# # https://illya13.github.io/RL/tutorial/2020/04/26/installing-tensorflow-on-ubuntu-20.html

# # switch gcc to 8
# sudo update-alternatives --config gcc

# # download cuda toolkit
# # wget http://developer.download.nvidia.com/compute/cuda/11.0.1/local_installers/cuda_11.0.1_450.36.06_linux.run

# # install the cida toolkit
# sudo bash cuda_11.0.1_450.36.06_linux.run

# # disable the driver

# # ensure that local paths are available
# echo -e '\nif [ -d "/usr/local/cuda-11.0/bin" ] ; then \n\tPATH="/usr/local/cuda-11.0/bin:$PATH" \nfi' >> $HOME/.profile
# echo -e '\nif [ -d "/usr/local/cuda-11.0/lib64" ] ; then \n\tLD_LIBRARY_PATH="/usr/local/cuda-11.0/lib64:$LD_LIBRARY_PATH" \nfi' >> $HOME/.profile

# rm /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcudnn.so.7
# sudo ln -s /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcudnn.so /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcudnn.so.7


# =============================================================================

# https://linuxconfig.org/how-to-install-cuda-on-ubuntu-20-04-focal-fossa-linux
sudo apt update

sudo apt install -y nvidia-cuda-toolkit
