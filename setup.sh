# =============================================================================
# VARIABLES
# =============================================================================
SETUP_FILE=$HOME/.linux_setup
WORKDIR=/media/sf_shared/projects


# =============================================================================
# FUNCTIONS
# =============================================================================
function setup {
	echo -e "\n\e[92m[setup]\e[0m > $1"
}

function message {
	echo -e "\e[92m[setup]\e[0m $1 \e[34m$2\e[0m"
}


# =============================================================================
# PROCESS
# =============================================================================
read -p "Name: (Willem Bressers)? " name; name=${name:-"Willem Bressers"}
read -p "Email: (dhr.bressers@gmail.com)? " email; email=${email:-"dhr.bressers@gmail.com"}


# -----------------------------------------------------------------------------
if [ ! -f $SETUP_FILE ]; then
	setup "$SETUP_FILE"

	# keep track of all installations in this file
	touch $SETUP_FILE

	# ensure it's loaded when a user logs in
	echo "source $SETUP_FILE" >> $HOME/.bashrc
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_GUEST_ADDITIONS ]; then
	setup "guest additions"

	read -p "--- INSERT GUEST ADDITIONS CD IMAGE --- " done; done=${done:-"yes"}

	# mount the cdrom
	sudo mount /dev/cdrom /mnt

	# run the  virtualbox additions script
	sudo /mnt/VBoxLinuxAdditions.run

	# add the user to the vboxsf group
	sudo usermod -aG vboxsf $USER

	echo "export SETUP_GUEST_ADDITIONS=installed" >> $SETUP_FILE

	# reboot (so that the vbox guest additions take effect)
	setup "reboot"
	shutdown -r now
fi


# -----------------------------------------------------------------------------
if [ ! -d $HOME/Desktop/projects ]; then
	setup "$WORKDIR"

	# create a working directory (in shared folder)
	mkdir -p $WORKDIR

	# symbolic link the directory to $HOME (for convience)
	ln -s $WORKDIR $HOME/projects
	ln -s $WORKDIR $HOME/Desktop/projects
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_BASH_ALIASES ]; then
	setup "$HOME/.bash_aliases"

	# create an bash aliases file 
	touch $HOME/.bash_aliases

	# create some conveniant cli shortcuts
	echo -e "\n# Global" >> $HOME/.bash_aliases
	echo -e "alias projects='cd \$HOME/projects'" >> $HOME/.bash_aliases

	# check if pcmanfm-qt is installed (commonly on lubuntu)
	if [ -z $(which pcmanfm-qt) ]; then
		echo -e "alias open=pcmanfm-qt" >> $HOME/.bash_aliases
	fi
	
	# check if natutilus is installed (commonly on ubuntu)
	if [ -z $(which nautilus) ]; then
		echo -e "alias open=nautilus" >> $HOME/.bash_aliases 
	fi

	echo "export SETUP_BASH_ALIASES=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_PYTHON_ENV ]; then
	setup "python environments"

	# download installer
	wget https://bootstrap.pypa.io/get-pip.py

	# install
	sudo python3 get-pip.py

	# remove install script
	rm get-pip.py

	# install python environment packages
	sudo pip install virtualenv virtualenvwrapper

	# create some conveniant cli shortcuts
	echo -e "\n# virtualenv and virtualenvwrapper" >> $HOME/.bashrc
	echo -e "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.bashrc
	echo -e "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> $HOME/.bashrc
	echo -e "source /usr/local/bin/virtualenvwrapper.sh" >> $HOME/.bashrc

	echo "export SETUP_PYTHON_ENV=installed" >> $SETUP_FILE
fi 


# -----------------------------------------------------------------------------
if [ -z $SETUP_MINICONDA ]; then
	setup "miniconda"

	# download installer
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

	# install
	bash Miniconda3-latest-Linux-x86_64.sh -u

	# remove install script
	rm  Miniconda3-latest-Linux-x86_64.sh

	# create some conveniant cli shortcuts
	echo -e "\n# Conda environments" >> $HOME/.bash_aliases
	echo -e "alias cec='conda create --name'" >> $HOME/.bash_aliases
	echo -e "alias cer='conda deactivate && conda env remove --name'" >> $HOME/.bash_aliases
	echo -e "alias cel='conda env list'" >> $HOME/.bash_aliases
	echo -e "alias cea='conda activate'" >> $HOME/.bash_aliases
	echo -e "alias ced='conda deactivate'" >> $HOME/.bash_aliases
	echo -e "\n# Conda packages" >> $HOME/.bash_aliases
	echo -e "alias cip='conda install'" >> $HOME/.bash_aliases

	echo "export SETUP_MINICONDA=installed" >> $SETUP_FILE
fi 


# -----------------------------------------------------------------------------
if [ -z $SETUP_SUBLIME ]; then
	setup "sublime-text"

	# why do i need this ??
	sudo apt-get install apt-transport-https

	# download the sublime key
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

	# add sublime sources to the package manager
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

	# update the sources
	sudo apt update -y

	# install the package
	sudo apt install -y sublime-text

	echo "export SETUP_SUBLIME=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_VIM ]; then
	setup "vim"

	# install vim
	sudo apt install -y vim
	
	echo "export SETUP_VIM=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_TERMINATOR ]; then
	setup "terminator"
	
	# install terminator
	sudo apt install -y terminator
	
	echo "export SETUP_TERMINATOR=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_SSH ]; then
	setup "ssh"

	# generate a key on the given email address
	ssh-keygen -t rsa -b 4096 -C $email
	
	message 'Add your ssh key to remote servers:' 'ssh-copy-id username@remote_host'

	# touch $HOME/.ssh/config
	# read -p "Axians server login name: (willem)? " name; name=${name:-"willem"}
	# echo -e "Host axians\n\tHostname xx.xxx.xxx.xx\n\tUser $name\n" >> $HOME/.ssh/config
	# chmod 600 $HOME/.ssh/config

	echo "export SETUP_SSH=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_GIT ]; then
	setup "git"

	# install git
	sudo apt install -y git

	# specify a global config & ignore files
	touch $HOME/.gitconfig
	touch $HOME/.gitignore
	
	# specify some global git configuration
	git config --global user.email $email
	git config --global user.name $name
	git config --global push.default simple
	git config --global core.excludesfile $HOME/.gitignore
	git config --global color.ui true
	git config --global core.editor vim

	# echo -e "parse_git_branch() { \n\t git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' \n}" >> $HOME/.bashrc
	# echo "PS1=\"\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ \"" >> $HOME/.bashrc
	
	# create some conveniant cli shortcuts
	echo -e "\n# Git" >> $HOME/.bash_aliases
	echo -e "alias ga='git add .'" >> $HOME/.bash_aliases
	echo -e "alias gb='git branch'" >> $HOME/.bash_aliases
	echo -e "alias gc='git commit --message'" >> $HOME/.bash_aliases
	echo -e "alias gd='git diff'" >> $HOME/.bash_aliases
	echo -e "alias gi='git init'" >> $HOME/.bash_aliases
	echo -e "alias gp='git pull'" >> $HOME/.bash_aliases
	echo -e "alias gpp='git pull && git push'" >> $HOME/.bash_aliases
	echo -e "alias gr='git reset'" >> $HOME/.bash_aliases
	echo -e "alias gs='git status'" >> $HOME/.bash_aliases
	echo -e "alias gst='git stash'" >> $HOME/.bash_aliases
	echo -e "alias gstp='git stash pop'" >> $HOME/.bash_aliases

	echo "export SETUP_GIT=installed" >> $SETUP_FILE
fi

# -----------------------------------------------------------------------------
if [ -z $SETUP_DOCKER ]; then
	setup "docker"

	# remove existing installation 
	sudo apt-get remove docker docker-engine docker.io containerd runc

	# update the system
	sudo apt-get update -y 

	# install the required OS dependencies
	sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common

	# download the docker key
	wget -qO - https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	# add docker sources to the package manager
	echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

	# update the sources
	sudo apt update -y

	# install the package(s)
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io

	# add the current user to the group
	sudo usermod -aG docker $USER

	echo "export SETUP_DOCKER=installed" >> $SETUP_FILE
fi


# # -----------------------------------------------------------------------------
# if [ ! -d $HOME/.virtualenvs ]; then
# 	setup "python3 & pip3"
# 	sudo apt install -y python3-pip python3-distutils

# 	setup "virtualenv"
# 	pip3 install --user virtualenv virtualenvwrapper
# 	echo "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.bashrc
# 	echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> $HOME/.bashrc
# 	echo "source $HOME/.local/bin/virtualenvwrapper.sh" >> $HOME/.bashrc
# 	# sudo ln -s /etc/python3 /etc/python

# 	# terminator needs python to be 2.7
# 	sudo ln -s /usr/bin/python2.7 /usr/bin/python
# fi

# # -----------------------------------------------------------------------------
# if [ -z "$SETUP_NODEJS" ]; then
# 	VERSION=v10.16.3
# 	DISTRO=linux-x64
	
# 	setup "nodejs"
# 	sudo mkdir -p /usr/local/lib/nodejs
# 	wget https://nodejs.org/dist/$VERSION/node-$VERSION-$DISTRO.tar.xz
# 	sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs
# 	rm node-$VERSION-$DISTRO.tar.xz
# 	sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/node /usr/bin/node
# 	sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npm /usr/bin/npm
# 	sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npx /usr/bin/npx

# 	echo "# Nodejs" >> $HOME/.profile
# 	echo "VERSION=${VERSION}" >> $HOME/.profile
# 	echo "DISTRO=${DISTRO}" >> $HOME/.profile
# 	echo "export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH" >> $HOME/.profile

# 	echo -e "\n# --- NODEJS ---" >> $HOME/.profile
# 	echo "export SETUP_NODEJS=installed" >> $HOME/.bashrc

# 	source $HOME/.profile
# 	jupyter labextension install jupyterlab-python-file
# fi

# -----------------------------------------------------------------------------
# if [ -z "$SETUP_NVIDIA_DOCKER" ]; then
# 	setup "nvidia-docker"
# 	distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
# 	curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
# 	curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# 	sudo apt-get --allow-releaseinfo-change update -y 
# 	sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
# 	sudo systemctl restart docker
# 	echo "export SETUP_NVIDIA_DOCKER=installed" >> $HOME/.bashrc
# fi

# -----------------------------------------------------------------------------

echo -e ""
message 'Activate all new settings:' 'source ~/.bashrc'
message 'Or reboot' 'shutdown -r now'
message 'DONE'