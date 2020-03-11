# =============================================================================
# VARIABLES
# =============================================================================
SETUP_FILE=$HOME/.linux_setup


# -----------------------------------------------------------------------------
if [ ! -f $SETUP_FILE ]; then
	# keep track of all installations in this file
	touch $SETUP_FILE

	# ensure it's loaded when a user logs in
	echo "export SETUP_FILE=$SETUP_FILE" >> $SETUP_FILE
	echo "source $SETUP_FILE" >> $HOME/.bashrc
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_USER_NAME ]; then
	read -p "Name: (Willem Bressers)? " name; name=${name:-"Willem Bressers"}

	echo "export SETUP_USER_NAME=$name" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_USER_EMAIL ]; then
	read -p "Email: (dhr.bressers@gmail.com)? " email; email=${email:-"dhr.bressers@gmail.com"}

	echo "export SETUP_USER_EMAIL=$email" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_GUEST_ADDITIONS ]; then
	# update OS
	sudo apt update
	sudo apt upgrade
	
	# install OS packages
	sudo apt-get install -y build-essential dkms linux-headers-$(uname -r)

	read -p "--- INSERT GUEST ADDITIONS CD IMAGE --- " done; done=${done:-"yes"}

	# mount the cdrom
	sudo mount /dev/cdrom /mnt

	# run the  virtualbox additions script
	sudo /mnt/VBoxLinuxAdditions.run

	# add the user to the vboxsf group
	sudo usermod -aG vboxsf $USER

	echo "export SETUP_GUEST_ADDITIONS=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_BASH_ALIASES ]; then
	# create an bash aliases file 
	touch $HOME/.bash_aliases

	# create some conveniant cli shortcuts
	echo -e "\n# Global" >> $HOME/.bash_aliases
	echo -e "alias projects='cd \$HOME/projects'" >> $HOME/.bash_aliases

	# check if pcmanfm-qt is installed (commonly on lubuntu)
	if [ -z $(which pcmanfm-qt) ]; then
		echo -e "alias open=pcmanfm-qt" >> $HOME/.bash_aliases
	elif [ -z $(which nautilus) ]; then
		echo -e "alias open=nautilus" >> $HOME/.bash_aliases 
	fi

	echo "export SETUP_BASH_ALIASES=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_BASH_FUNCTIONS ]; then
	# create an bash functions file 
	touch $HOME/.bash_functions

	# ensure it's loaded when a user logs in
	echo "source $HOME/.bash_functions" >> $HOME/.bashrc

	echo "export SETUP_BASH_FUNCTIONS=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_SSH ]; then
	# generate a key on the given email address
	ssh-keygen -t rsa -b 4096 -C $email

	echo "export SETUP_SSH=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_UPDATE_OS ]; then
	# upgrade all packages
	sudo apt-get upgrade -y

	# remove cloud init
	echo 'datasource_list: [ None ]' | sudo -s tee /etc/cloud/cloud.cfg.d/90_dpkg.cfg
	sudo apt-get purge cloud-init -y
	sudo rm -rf /etc/cloud/; sudo rm -rf /var/lib/cloud/

	echo "export SETUP_UPDATE_OS=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_GIT ]; then
	# install git
	sudo apt install -y git

	# specify a global config & ignore files
	touch $HOME/.gitconfig
	touch $HOME/.gitignore
	
	# specify some global git configuration
	git config --global user.email $SETUP_USER_EMAIL
	git config --global user.name $SETUP_USER_NAME
	git config --global push.default simple
	git config --global core.excludesfile $HOME/.gitignore
	git config --global color.ui true
	git config --global core.editor vim

	echo "export SETUP_GIT=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_VIM ]; then
	# install vim
	sudo apt install -y vim
	
	echo "export SETUP_VIM=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
shutdown -r now
