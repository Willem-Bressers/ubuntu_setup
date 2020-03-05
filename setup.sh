# =============================================================================
# VARIABLES
# =============================================================================
SETUP_FILE=$HOME/.linux_setup


# =============================================================================
# FUNCTIONS
# =============================================================================
function message {
	echo -e "\e[92m[setup]\e[0m $1 \e[34m$2\e[0m"
}


# -----------------------------------------------------------------------------
if [ ! -f $SETUP_FILE ]; then
	message "$SETUP_FILE"

	# keep track of all installations in this file
	touch $SETUP_FILE

	# ensure it's loaded when a user logs in
	echo "export SETUP_FILE=$SETUP_FILE" >> $SETUP_FILE
	echo "source $SETUP_FILE" >> $HOME/.bashrc
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_USER_NAME ]; then
	message "user name"

	read -p "Name: (Willem Bressers)? " name; name=${name:-"Willem Bressers"}

	echo "export SETUP_USER_NAME=$name" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_USER_EMAIL ]; then
	message "user email"

	read -p "Email: (dhr.bressers@gmail.com)? " email; email=${email:-"dhr.bressers@gmail.com"}

	echo "export SETUP_USER_EMAIL=$email" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_GUEST_ADDITIONS ]; then
	message "guest additions"
	
	KERNEL_RELEASE=$(uname –r)
	
	# install OS packages
	sudo apt-get install -y build-essential linux-headers-$KERNEL_RELEASE

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
	message "$HOME/.bash_aliases"

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
	message "$HOME/.bash_functions"

	# create an bash functions file 
	touch $HOME/.bash_functions

	# ensure it's loaded when a user logs in
	echo "source $HOME/.bash_functions" >> $HOME/.bashrc

	# echo -e "\nfunction message {\n\techo -e \"\e[92m[setup]\e[0m $1 \e[34m$2\e[0m\"}" >> $HOME/.bash_functions

	echo "export SETUP_BASH_FUNCTIONS=installed" >> $SETUP_FILE
fi


# -----------------------------------------------------------------------------
if [ -z $SETUP_SSH ]; then
	message "ssh"

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
if [ -z $SETUP_UPDATE_OS ]; then
	message "update OS"

	# upgrade all packages
	sudo apt-get upgrade -y

	# remove cloud init
	echo 'datasource_list: [ None ]' | sudo -s tee /etc/cloud/cloud.cfg.d/90_dpkg.cfg
	sudo apt-get purge cloud-init -y
	sudo rm -rf /etc/cloud/; sudo rm -rf /var/lib/cloud/

	echo "export SETUP_UPDATE_OS=installed" >> $SETUP_FILE
fi

# -----------------------------------------------------------------------------
message 'DONE'
message '(rebooting)'
shutdown -r now
