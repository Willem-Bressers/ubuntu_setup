if [ -z $SETUP_SUBLIME ]; then
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

