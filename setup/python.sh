# download installer
sudo apt install -y python3-pip

# install npm for jupyter lab extensions
sudo apt install -y npm

# install python environment packages
pip3 install virtualenv virtualenvwrapper

echo -e "\n# Add local bin (for the virtualenv)" >> $HOME/.bashrc
echo -e "PATH=$PATH:$HOME/.local/bin" >> $HOME/.bashrc

echo -e "\n# virtualenv and virtualenvwrapper environment variables" >> $HOME/.bashrc
echo -e "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.bashrc
echo -e "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> $HOME/.bashrc

echo -e "\n# source the virtualenvwrapper code" >> $HOME/.bashrc
echo -e "source $HOME/.local/bin/virtualenvwrapper.sh" >> $HOME/.bashrc

# ensure bash is sourced (with new addtions)
echo -e "\e[31mRun\e[0m source ~/.bashrc"