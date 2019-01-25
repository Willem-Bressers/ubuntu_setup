#! /bin/bash

# =============================================================================
# Ubuntu packages
# =============================================================================
sudo apt install -y vim git python3-pip python3-distutils nodejs npm
sudo apt autoremove -y


# =============================================================================
# USER setup
# =============================================================================
if [ ! -f ~/.bash_aliases ]; then
	touch ~/.bash_aliases
fi

if [ ! -f ~/.bash_profile ]; then
	touch ~/.bash_profile
fi

if [ ! -f ~/.pam_environment ]; then
	touch ~/.pam_environment
fi

if [ ! -f ~/.gitignore ]; then
	touch ~/.gitignore
fi

# =============================================================================
# SETUP GIT
# =============================================================================

if [ ! -f ~/.ssh/id_rsa.pub ]; then
	read -p "Email: (dhr.bressers@gmail.com)? " email; email=${email:-"dhr.bressers@gmail.com"}
	ssh-keygen -t rsa -b 4096 -C $email
	cat ~/.ssh/id_rsa.pub

	if [ ! -f ~/.gitconfig ]; then
		read -p "Name: (Willem Bressers)? " name; name=${name:-"Willem Bressers"}
		git config --global user.email $email
		git config --global user.name $name
		git config --global push.default simple
		git config --global core.excludesfile ~/.gitignore
	fi

	# update our  ~/.bashrc  file
	echo -e "\n# GIT settings" >> ~/.bashrc
	echo -e "parse_git_branch() {
		\tgit branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
	}" >> ~/.bashrc
	echo "PS1=\"\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ \"" >> ~/.bashrc
fi

if [ ! -f ~/.ssh/config ]; then
	touch ~/.ssh/config
	read -p "Axians server login name: (willem)? " name; name=${name:-"willem"}
	echo -e "Host axians\n\tHostname 10.249.153.16\n\tUser $name\n" >> ~/.ssh/config
	chmod 600 ~/.ssh/config
fi

# =============================================================================
# SETUP PROJECTS
# =============================================================================
if [ ! -d ~/projects ]; then
	mkdir ~/projects
	ln -s ~/projects ~/Desktop/projects
fi

# =============================================================================
# SETUP PYTHON
# =============================================================================
if [ ! -d $HOME/.virtualenvs ]; then
	# install python libraries
	sudo pip3 install virtualenv virtualenvwrapper

	# update our  ~/.bashrc  file
	echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
	echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
	echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
	echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
fi
