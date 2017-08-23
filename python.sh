# # install miniconda
# wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# bash Miniconda3-latest-Linux-x86_64.sh
# source ~/.bashrc

# # install cookiecutter
# pip install cookiecutter

# install pip3
sudo apt-get -y install python3-pip
pip3 install --upgrade pip

# install virtualenvwrapper
pip3 install virtualenvwrapper
echo export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3 >> ~/.bashrc
echo export WORKON_HOME=$HOME/.virtualenvs >> ~/.bashrc
echo export PROJECT_HOME=$HOME/Devel >> ~/.bashrc
echo source $HOME/.local/bin/virtualenvwrapper.sh >> ~/.bashrc
source ~/.bashrc
mkdir $PROJECT_HOME