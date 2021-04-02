# download installer
sudo apt install -y python3-pip

# install python environment packages
pip3 install virtualenv virtualenvwrapper

echo -e "\n# Add local bin (for the virtualenv)" >> $HOME/.zshrc
echo -e "PATH=$PATH:$HOME/.local/bin" >> $HOME/.zshrc

echo -e "\n# virtualenv and virtualenvwrapper environment variables" >> $HOME/.zshrc
echo -e "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.zshrc
echo -e "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> $HOME/.zshrc

echo -e "\n# source the virtualenvwrapper code" >> $HOME/.zshrc
echo -e "source $HOME/.local/bin/virtualenvwrapper.sh" >> $HOME/.zshrc

# ensure bash is sourced (with new addtions)
echo -e "\e[31mRun\e[0m source ~/.zshrc"