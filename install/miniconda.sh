if [ -z $SETUP_MINICONDA ]; then
	# download installer
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

	# install
	bash Miniconda3-latest-Linux-x86_64.sh -u

	# remove install script
	rm  Miniconda3-latest-Linux-x86_64.sh

	# create some conveniant cli shortcuts
	echo -e "\n# Conda environments" >> $HOME/.bash_aliases
	echo -e "alias cec='conda create --name'" >> $HOME/.bash_aliases
	echo -e "alias cer='conda deactivate && conda env remove --name'" >> $HOME/.bash_aliases
	echo -e "alias cel='conda env list'" >> $HOME/.bash_aliases
	echo -e "alias cea='conda activate'" >> $HOME/.bash_aliases
	echo -e "alias ced='conda deactivate'" >> $HOME/.bash_aliases
	echo -e "\n# Conda packages" >> $HOME/.bash_aliases
	echo -e "alias cip='conda install'" >> $HOME/.bash_aliases

	echo "export SETUP_MINICONDA=installed" >> $SETUP_FILE
fi 
