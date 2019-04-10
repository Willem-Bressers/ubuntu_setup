#! /bin/bash

# =================== OS dependencies =================== 
sudo apt update
sudo apt install -y r-base gdebi-core

# =================== R packages OS dependencies ===================
# plotly
sudo apt install -y libssl-dev libcurl4-openssl-dev

cd ~/Downloads
if [ ! -f ~/Downloads/rstudio-xenial-1.1.463-amd64.deb ]; then
	wget https://download1.rstudio.org/rstudio-xenial-1.1.463-amd64.deb 
fi
sudo gdebi rstudio-xenial-1.1.463-amd64.deb 