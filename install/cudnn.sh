# download cudnn at https://developer.nvidia.com/rdp/cudnn-download

# cd ~/Downloads
# sudo dpkg -i libcudnn8_8.0.0.180-1+cuda10.2_amd64.deb
# sudo dpkg -i libcudnn8-dev_8.0.0.180-1+cuda10.2_amd64.deb
# sudo dpkg -i libcudnn8-doc_8.0.0.180-1+cuda10.2_amd64.deb

# cp -r /usr/src/cudnn_samples_v8/ $HOME
# cd $HOME/cudnn_samples_v8/mnistCUDNN
# make clean && make
# ./mnistCUDNN



# https://illya13.github.io/RL/tutorial/2020/04/26/installing-tensorflow-on-ubuntu-20.html
cd ~/Downloads
tar -xzvf cudnn-11.0-linux-x64-v8.0.0.180.tgz

sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

# rm /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcudnn.so.8.0.0
# rm /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcudnn.so.8
# rm /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcudnn.so
# sudo ln -s libcudnn.so.7.6.5 /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcudnn.so.7
# sudo ln -s libcudnn.so.7 /usr/local/cuda-11.0/targets/x86_64-linux/lib/libcudnn.so
# sudo ldconfig