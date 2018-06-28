#!/usr/bin/env bash

sudo apt update

# Install R
sudo apt install -y r-base

# sudo apt install -y gdebi-core libjpeg62 r-base libssl-dev libcurl4-openssl-dev unixodbc-dev

# echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
# Rscript -e "install.packages('odbc')"
# Rscript -e "install.packages('packrat')"
# Rscript -e "install.packages('devtools')"

# wget -O $HOME/Downloads/rstudio.deb https://download1.rstudio.org/rstudio-xenial-1.1.447-amd64.deb

# sudo dpkg -i $HOME/Downloads/rstudio.deb