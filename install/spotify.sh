if [ -z $SETUP_SPOTIFY ]; then
	# install application 
	# sudo snap install spotify

	# download the key
	wget -qO - https://download.spotify.com/debian/pubkey.gpg  | sudo apt-key add -

	# add sublime sources to the package manager
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	
	# update the sources
	sudo apt update -y

	# install the package
	sudo apt-get install spotify-client

	echo "export SETUP_SPOTIFY=installed" >> $SETUP_FILE
fi
