DISTRO=$(lsb_release -cs)

# Secure APT
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -
echo "deb https://cloud.r-project.org/bin/linux/ubuntu $DISTRO-cran35/" | sudo tee /etc/apt/sources.list.d/rstudio.list

# install OS dependencies
sudo apt-get update
sudo apt-get install -y r-base r-base-dev gdebi-core

# install R-studio
wget https://download2.rstudio.org/server/$DISTRO/amd64/rstudio-server-1.2.5033-amd64.deb -O /var/tmp/rstudio-server-1.2.5033-amd64.deb
sudo gdebi -y /var/tmp/rstudio-server-1.2.5033-amd64.deb 

# info
echo "http://<server-ip>:8787"
echo "login = root + root_pass"