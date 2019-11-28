if [ -z $SETUP_VIM ]; then
	# install vim
	sudo apt install -y vim
	
	echo "export SETUP_VIM=installed" >> $SETUP_FILE
fi
