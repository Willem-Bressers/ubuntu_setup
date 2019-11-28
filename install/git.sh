if [ -z $SETUP_GIT ]; then

	# install git
	sudo apt install -y git

	# specify a global config & ignore files
	touch $HOME/.gitconfig
	touch $HOME/.gitignore
	
	# specify some global git configuration
	git config --global user.email $SETUP_USER_EMAIL
	git config --global user.name $SETUP_USER_NAME
	git config --global push.default simple
	git config --global core.excludesfile $HOME/.gitignore
	git config --global color.ui true
	git config --global core.editor vim

	# echo -e "parse_git_branch() { \n\t git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/' \n}" >> $HOME/.bashrc
	# echo "PS1=\"\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ \"" >> $HOME/.bashrc
	
	# create some conveniant cli shortcuts
	echo -e "\n# Git" >> $HOME/.bash_aliases
	# echo -e "alias gsync='git add . && git commit -am \"\$@\" && git pull && git push'" >> $HOME/.bash_aliases
	echo -e "alias ga='git add .'" >> $HOME/.bash_aliases
	echo -e "alias gb='git branch'" >> $HOME/.bash_aliases
	echo -e "alias gc='git commit --message'" >> $HOME/.bash_aliases
	echo -e "alias gd='git diff'" >> $HOME/.bash_aliases
	echo -e "alias gi='git init'" >> $HOME/.bash_aliases
	echo -e "alias gp='git pull'" >> $HOME/.bash_aliases
	echo -e "alias gpp='git pull && git push'" >> $HOME/.bash_aliases
	echo -e "alias gr='git reset'" >> $HOME/.bash_aliases
	echo -e "alias gs='git status'" >> $HOME/.bash_aliases
	echo -e "alias gst='git stash'" >> $HOME/.bash_aliases
	echo -e "alias gstp='git stash pop'" >> $HOME/.bash_aliases

	echo "export SETUP_GIT=installed" >> $SETUP_FILE
fi
