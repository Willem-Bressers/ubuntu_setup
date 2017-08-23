# Do this only once
if [ ! -f ~/.ubuntu_setup ]; then
	# add user to virtualbox
	sudo adduser $(whoami) vboxsf

	# update ubuntu
	sudo apt update -y
	sudo apt upgrade -y

	# install java
	sudo apt install default-jre

	# install vim
	sudo apt install vim -y

	touch ~/.ubuntu_setup
fi

# setup ssh
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -b 4096 -C "info@willembressers.nl"
	cat ~/.ssh/id_rsa.pub
fi

# install sublime
function install_git {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt update -y
	sudo apt install sublime-text
}

# install git
function install_git {
	sudo apt install git -y
	git config --global user.email "info@willembressers.nl"
	git config --global user.name "Willem Bressers"
	git config --global core.editor "vim"
	git config --global push.default simple
	git config --global core.excludesfile ~/.gitignore
	touch ~/.gitignore
}

# install cuda
function install_cuda {
	cd ~/Desktop/Projects
	wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
	sudo dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
	sudo apt-get update
	sudo apt-get install cuda
}

# install opencv
function install_opencv {
	# OS dependencies
	sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

	cd ~/Desktop/Projects
	wget https://github.com/opencv/opencv/archive/3.3.0.zip
	unzip 3.3.0.zip
	cd opencv-3.3.0/
	mkdir build
	cd build
	cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
	make -j4
}

# install darknet
function install_darknet {
	cd ~/Desktop/Projects
	git clone https://github.com/pjreddie/darknet.git
	cd darknet
	make
	mkdir -p obj
	wget https://pjreddie.com/media/files/yolo.weights
	wget https://pjreddie.com/media/files/tiny-yolo-voc.weights
}

# instal docker
function install_docker {
	# install curl
	sudo apt-get install curl

	# add the GPG key
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	# Add the Docker repository to APT sources
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

	# update the package database
	sudo apt-get update

	# install Docker
	sudo apt-get install -y docker-ce

	# add your username to the docker group
	sudo usermod -aG docker ${USER}
	su - ${USER}
}

# install pip3
function install_pip {
	sudo apt-get -y install python3-pip
	pip3 install --upgrade pip
}

# install virtualenvwrapper
function install_virtualenvwrapper {
	pip3 install virtualenvwrapper
	echo export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3 >> ~/.bashrc
	echo export WORKON_HOME=$HOME/.virtualenvs >> ~/.bashrc
	echo export PROJECT_HOME=$HOME/Devel >> ~/.bashrc
	echo source $HOME/.local/bin/virtualenvwrapper.sh >> ~/.bashrc
	source ~/.bashrc
	mkdir $PROJECT_HOME
}