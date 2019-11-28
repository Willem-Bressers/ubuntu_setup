if [ -z $SETUP_PYTHON_ENV ]; then
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

