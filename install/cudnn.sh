# download cudnn at https://developer.nvidia.com/rdp/cudnn-download

cd ~/Downloads
sudo dpkg -i libcudnn8_8.0.0.180-1+cuda10.2_amd64.deb
sudo dpkg -i libcudnn8-dev_8.0.0.180-1+cuda10.2_amd64.deb
sudo dpkg -i libcudnn8-doc_8.0.0.180-1+cuda10.2_amd64.deb

cp -r /usr/src/cudnn_samples_v8/ $HOME
cd $HOME/cudnn_samples_v8/mnistCUDNN
make clean && make
./mnistCUDNN