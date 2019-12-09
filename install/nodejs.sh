if [ -z $SETUP_NODEJS ]; then
	VERSION=v10.16.3
	DISTRO=linux-x64
	
	sudo mkdir -p /usr/local/lib/nodejs
	wget https://nodejs.org/dist/$VERSION/node-$VERSION-$DISTRO.tar.xz
	sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs
	rm node-$VERSION-$DISTRO.tar.xz
	sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/node /usr/bin/node
	sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npm /usr/bin/npm
	sudo ln -s /usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin/npx /usr/bin/npx

	echo "# Nodejs" >> $HOME/.profile
	echo "VERSION=${VERSION}" >> $HOME/.profile
	echo "DISTRO=${DISTRO}" >> $HOME/.profile
	echo "export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH" >> $HOME/.profile
	source $HOME/.profile
	
	# jupyter labextension install jupyterlab-python-file
	
	echo "export SETUP_NODEJS=installed" >> $SETUP_FILE
fi
