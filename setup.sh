WORKDIR=/media/sf_shared/projects

#sudo adduser $(whoami) vboxsf

# =============================================================================
# SETUP 
# =============================================================================
sudo apt install -y vim terminator

# =============================================================================
# SETUP PROJECTS
# =============================================================================
if [ ! -d $WORKDIR ]; then
	mkdir $WORKDIR

fi

if [ ! -d $HOME/Desktop/projects ]; then
	ln -s $WORKDIR $HOME/Desktop/projects
fi

# =============================================================================
# USER setup
# =============================================================================
if [ ! -f $HOME/.bash_aliases ]; then
	touch $HOME/.bash_aliases
fi

if [ ! -f $HOME/.bash_profile ]; then
	touch $HOME/.bash_profile
fi

if [ ! -f $HOME/.pam_environment ]; then
	touch $HOME/.pam_environment
fi

if [ ! -f $HOME/.gitignore ]; then
	touch $HOME/.gitignore
fi

# =============================================================================
# SETUP PYTHON
# =============================================================================
sudo apt install -y python3-pip python3-distutils

if [ ! -d $HOME/.virtualenvs ]; then
	# install python libraries
	sudo pip3 install virtualenv virtualenvwrapper

	# update our  ~/.bashrc  file
	echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
	echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
	echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
	echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
fi

# =============================================================================
# SETUP GIT
# =============================================================================
sudo apt install -y git

if [ ! -f $HOME/.ssh/id_rsa.pub ]; then
	read -p "Email: (dhr.bressers@gmail.com)? " email; email=${email:-"dhr.bressers@gmail.com"}
	ssh-keygen -t rsa -b 4096 -C $email
	cat $HOME/.ssh/id_rsa.pub

	if [ ! -f $HOME/.gitconfig ]; then
		read -p "Name: (Willem Bressers)? " name; name=${name:-"Willem Bressers"}
		git config --global user.email $email
		git config --global user.name $name
		git config --global push.default simple
		git config --global core.excludesfile $HOME/.gitignore
		git config --global color.ui true
	fi

	# update our  ~/.bashrc  file
	echo -e "\n# GIT settings" >> $HOME/.bashrc
	echo -e "parse_git_branch() {
		\tgit branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
	}" >> $HOME/.bashrc
	echo "PS1=\"\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ \"" >> $HOME/.bashrc
fi

if [ ! -f $HOME/.ssh/config ]; then
	touch $HOME/.ssh/config
	read -p "Axians server login name: (willem)? " name; name=${name:-"willem"}
	echo -e "Host axians\n\tHostname 10.249.153.16\n\tUser $name\n" >> $HOME/.ssh/config
	chmod 600 $HOME/.ssh/config
fi

# =============================================================================
# SETUP SUBLIME
# =============================================================================
if [ -z "$SETUP_SUBLIME" ]; then
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

	sudo apt update -y
	sudo apt install -y sublime-text
	echo "export SETUP_SUBLIME=installed" >> ~/.bashrc
fi
