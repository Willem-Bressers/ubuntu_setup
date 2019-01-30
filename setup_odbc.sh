#! /bin/bash

# download dependencies
sudo apt install -y curl gnupg apt-transport-https libcurl4

# add the microsoft apt repository
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(curl -s https://packages.microsoft.com/config/ubuntu/$(lsb_release -r -s)/prod.list)"

# install the drivers
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17
sudo apt install -y unixodbc-dev

# show the settings
cat /etc/odbcinst.ini 