if [ -z $SETUP_DOCKER ]; then
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
