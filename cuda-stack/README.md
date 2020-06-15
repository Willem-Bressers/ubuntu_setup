# CUDA stack

=============================================================================
see https://www.tensorflow.org/install/source#gpu
see https://docs.nvidia.com/deploy/cuda-compatibility/#source-compatibility

My goal is to install tensorflow-gpu 2.2.0 locally
so we need: 
- cudnn 7.6 (we cant go higher now because tensorflow is compiled with this version)
- cuda 10.1 (because cudnn 7.6 relies on cuda 10.1)
=============================================================================


## Install NVIDIA drivers

first install nvidia drivers
bash```
	# open the additional drivers and select the appropriate NVIDIA drivers (see https://docs.nvidia.com/deploy/cuda-compatibility/#source-compatibility)
	software-properties-gtk --open-tab=4

	# OR install ALL drivers (and thus the most recent NVIDIA drivers)
	sudo ubuntu-drivers autoinstall
```

reboot after a fresh installation
bash```
	sudo reboot
```

After the reboot, you can verify 
bash```
	nvidia-smi
```
Somehow cuda 10.2 whas shown in the `nvidia-smi` command, but i couldn't use it


## Install CUDA toolkit
Download the cuda toolkit 
bash```
	# Manually
	firefox https://developer.nvidia.com/cuda-10.1-download-archive-update2

	# OR via CLI
	wget http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run
```

Before we can run the installer, we must change the GCC version to 8 (see https://docs.nvidia.com/cuda/archive/10.1/cuda-installation-guide-linux/index.html#system-requirements). I'm installing on Ubuntu 20.04 which by default contains GCC version 9
bash```
	sudo apt -y install build-essential
	sudo apt -y install gcc-8 g++-8 gcc-9 g++-9

	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8 --slave /usr/bin/g++ g++ /usr/bin/g++-8
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9 --slave /usr/bin/g++ g++ /usr/bin/g++-9

	# select gcc-8
	sudo update-alternatives --config gcc
```

Now we can install CUDA
bash```
	sudo sh cuda_10.1.243_418.87.00_linux.run
```

Be sure to deselect the driver
bash```
	x CUDA Installer                                                               x
	x - [ ] Driver                                                                 x
	x      [ ] 418.87.00                                                           x
	x + [X] CUDA Toolkit 10.1                                                      x
	x   [X] CUDA Samples 10.1                                                      x
	x   [X] CUDA Demo Suite 10.1                                                   x
	x   [X] CUDA Documentation 10.1                                                x
	x   Options                                                                    x
	x   Install                                                                    x
```

Now add the paths to the `~/.bashrc` file
bash```
	export PATH=/usr/local/cuda-10.1/bin:$PATH
	export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH
	# export CUDA_HOME=/usr/local/cuda-10.1
```

# now let's reload the ~/.bashrc file
bash```
	source ~/.bashrc
```

and we can test the CUDA version
bash```
	nvcc --version
```


## Install CUDNN
Download cuDNN
bash```
	firefox https://developer.nvidia.com/rdp/cudnn-archive
	# create an account
	# open `Download cuDNN v7.6.4 (September 27, 2019), for CUDA 10.1` and download
	# - cuDNN Runtime Library for Ubuntu18.04 (Deb)
	# - cuDNN Developer Library for Ubuntu18.04 (Deb)
	# - cuDNN Code Samples and User Guide for Ubuntu18.04 (Deb)
```

Install the packages
bash```
	sudo dpkg -i libcudnn7_7.6.4.38-1+cuda10.1_amd64.deb
	sudo dpkg -i libcudnn7-dev_7.6.4.38-1+cuda10.1_amd64.deb
	sudo dpkg -i libcudnn7-doc_7.6.4.38-1+cuda10.1_amd64.deb
```

Now we can test cuDNN
bash```
	cp -r /usr/src/cudnn_samples_v7/ $HOME
	cd  $HOME/cudnn_samples_v7/mnistCUDNN
	make clean && make
	./mnistCUDNN
```

## Install Tensorflow
bash```
	pip install tensorflow-gpu=2.2.0
```

Test tensorflow
bash```
	git clone https://github.com/tensorflow/benchmarks
	python benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py --num_gpus=1 --model resnet50 --batch_size 64
```

You should be able to monitor the training process on the GPU
bash```
	watch nvidia-smi
```

Thanks to:
[https://illya13.github.io/RL/tutorial/2020/04/26/installing-tensorflow-on-ubuntu-20.html](https://illya13.github.io/RL/tutorial/2020/04/26/installing-tensorflow-on-ubuntu-20.html)
[https://towardsdatascience.com/tensorflow-gpu-installation-made-easy-ubuntu-version-4260a52dd7b0](https://towardsdatascience.com/tensorflow-gpu-installation-made-easy-ubuntu-version-4260a52dd7b0)