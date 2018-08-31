#! /bin/bash

sudo apt install -y git

if [ ! -f ~/.gitignore ]; then
	touch ~/.gitignore
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