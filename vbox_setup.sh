#! /bin/bash

# =============================================================================
# SETUP BASH
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

# =============================================================================
# SETUP GIT
# =============================================================================
sudo apt install -y git

if [ ! -f ~/.gitignore ]; then
	touch ~/.gitignore
fi

if [ ! -f ~/.ssh/id_rsa.pub ]; then
	read -p "Email: (dhr.bressers@gmail.com)? " email; email=${email:-"dhr.bressers@gmail.com"}
	ssh-keygen -t rsa -b 4096 -C $email
	cat ~/.ssh/id_rsa.pub
fi

if [ ! -f ~/.gitconfig ]; then
	read -p "Email: (dhr.bressers@gmail.com)? " email; email=${email:-"dhr.bressers@gmail.com"}
	read -p "Name: (Willem Bressers)? " name; name=${name:-"Willem Bressers"}
	git config --global user.email $email
	git config --global user.name $name
	git config --global push.default simple
	git config --global core.excludesfile ~/.gitignore
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
sudo apt install -y python3-pip python3-distutils

sudo pip3 install virtualenv virtualenvwrapper

echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
