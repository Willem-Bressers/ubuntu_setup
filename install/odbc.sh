if [ -z $SETUP_ODBC ]; then
	sudo apt-get install -y curl

	# =========================================================================
	# SQL SEVER DRIVER
	# =========================================================================
	sudo su 

	# download the key
	curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

	# add sources to the package manager
	curl https://packages.microsoft.com/config/ubuntu/19.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

	exit

	# update the sources
	sudo apt update -y

	# install the package(s)
	sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17

	# install mssql tools
	sudo ACCEPT_EULA=Y apt-get install -y mssql-tools
	echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
	echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
	source ~/.bashrc

	# =========================================================================
	# ODBC
	# =========================================================================

	# install os packages
	sudo apt-get install unixodbc-dev


	# =========================================================================
	# DBEAVER
	# =========================================================================
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt update
	sudo apt install oracle-java8-set-default

	echo "export SETUP_ODBC=installed" >> $SETUP_FILE
fi
