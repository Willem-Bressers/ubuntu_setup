if [ -z $SETUP_PDF ]; then
	# install vim
	sudo apt install -y pandoc texlive-full
	
	echo "export SETUP_PDF=installed" >> $SETUP_FILE
fi
