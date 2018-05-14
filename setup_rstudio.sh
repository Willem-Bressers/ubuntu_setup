#!/usr/bin/env bash

sudo apt update

sudo apt install -y gdebi-core libjpeg62 r-base

wget -O $HOME/Downloads/rstudio.deb https://download1.rstudio.org/rstudio-xenial-1.1.447-amd64.deb

sudo dpkg -i $HOME/Downloads/rstudio.deb