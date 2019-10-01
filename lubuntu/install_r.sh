#! /bin/bash

# see: https://csgillespie.github.io/efficientR/set-up.html

# =============================================================================
# ensure ubuntu get the latest R versions
# =============================================================================
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo rm -rf /etc/apt/sources.list.d/r.list
echo "deb https://cloud.r-project.org/bin/linux/ubuntu cosmic-cran35/" | sudo tee /etc/apt/sources.list.d/r.list
sudo apt-get update

# =============================================================================
# install R
# =============================================================================
sudo apt-get install -y r-cran-base r-cran-rcurl gdebi-core

# =============================================================================
# install OS requirements for certain packages
# =============================================================================
sudo apt-get install -y libcurl4-openssl-dev libgit2-dev libssl-dev libssh2-1-dev unixodbc-dev

# =============================================================================
# download & install Rstudio
# =============================================================================
if [ ! -f ~/rstudio-server.deb ]; then
	# download
	wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb -O ~/rstudio-server.deb

	# install
	sudo gdebi ~/rstudio-server.deb

	# remove download file
	rm -rf ~/rstudio-server.deb
fi

# symbolic link to mounted shared folder
ln -s /media/sf_shared/projects/ ~/projects

# Ensure portforwarding is set from 8787 (host) to 8787 (guest)
