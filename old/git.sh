#! /bin/bash

sudo apt install -y git

if [ ! -f ~/.gitignore ]; then
	touch ~/.gitignore

	echo '
	parse_git_branch() {
		git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
	}

	PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "' >> ~/.bashrc
fi

read -p "Email: (dhr.bressers@gmail.com)? " email; email=${email:-"dhr.bressers@gmail.com"}
if [ ! -f ~/.ssh/id_rsa.pub ]; then
	ssh-keygen -t rsa -b 4096 -C $email
fi
cat ~/.ssh/id_rsa.pub

read -p "Name: (Willem Bressers)? " name; name=${name:-"Willem Bressers"}
if [ ! -f ~/.gitconfig ]; then
	git config --global user.email $email
	git config --global user.name $name
	git config --global push.default simple
	git config --global core.excludesfile ~/.gitignore
fi 