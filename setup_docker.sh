#!/usr/bin/env bash

sudo apt install -y docker.io

sudo systemctl start docker
sudo systemctl enable docker

# sudo apt update
# sudo apt install apt-transport-https ca-certificates curl software-properties-common

# echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo apt-get update

# sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}

# su - ${USER}