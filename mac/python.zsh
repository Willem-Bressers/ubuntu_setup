# load colors (for echo-ing)
autoload colors;
colors;

# install python environment packages
pip3 install virtualenv virtualenvwrapper

echo "\n# Add local bin (for the virtualenv)" >> $HOME/.zshrc
echo "PATH=$PATH:$HOME/.local/bin" >> $HOME/.zshrc

echo "\n# virtualenv and virtualenvwrapper environment variables" >> $HOME/.zshrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.zshrc
echo "export VIRTUALENVWRAPPER_PYTHON=$(which python3)" >> $HOME/.zshrc

echo "\n# source the virtualenvwrapper code" >> $HOME/.zshrc
echo "source $(dirname $(which pip3))/virtualenvwrapper.sh" >> $HOME/.zshrc

# ensure bash is sourced (with new addtions)
echo $fg_bold[red]"Run"$reset_color" :source ~/.zshrc"
