#! /bin/bash

# remove old-docker and update OS
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update -y 
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# get the repository key and install
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# post install
sudo usermod -aG docker $USER
shutdown -r now