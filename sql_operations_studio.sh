#! /bin/bash

sudo apt install -y libxss1 libgconf-2-4 libunwind8

wget -O $HOME/Downloads/sqlops-linux.deb https://go.microsoft.com/fwlink/?linkid=873391

sudo dpkg -i $HOME/Downloads/sqlops-linux.deb