# load colors (for echo-ing)
autoload colors;
colors;

# install python environment packages
pip3 install virtualenv virtualenvwrapper

echo "\n# Add local bin (for the virtualenv)" >> $HOME/.bashrc
echo "PATH=$PATH:$HOME/.local/bin" >> $HOME/.bashrc

echo "\n# virtualenv and virtualenvwrapper environment variables" >> $HOME/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=$(which python3)" >> $HOME/.bashrc

echo "\n# source the virtualenvwrapper code" >> $HOME/.bashrc
echo "source $(dirname $(which pip3))/virtualenvwrapper.sh" >> $HOME/.bashrc

# ensure bash is sourced (with new addtions)
echo $fg_bold[red]"Run"$reset_color": source ~/.bashrc"
