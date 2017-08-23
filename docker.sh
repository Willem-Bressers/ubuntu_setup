# install curl
sudo apt-get install curl

# add the GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# update the package database
sudo apt-get update

# install Docker
sudo apt-get install -y docker-ce

# add your username to the docker group
sudo usermod -aG docker ${USER}
su - ${USER}
