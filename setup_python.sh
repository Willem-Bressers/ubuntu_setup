#!/usr/bin/env bash

cd ~

wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo rm -rf ~/get-pip.py ~/.cache/pip

sudo pip install virtualenv virtualenvwrapper

echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc