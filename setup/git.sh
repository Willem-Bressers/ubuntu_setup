# install git
sudo apt install -y git vim

# specify a global config & ignore files
touch $HOME/.gitconfig
touch $HOME/.gitignore

# specify some global git configuration
git config --global user.email "dhr.bressers@gmail.com"
git config --global user.name "Willem Bressers"
git config --global push.default simple
git config --global core.excludesfile $HOME/.gitignore
git config --global color.ui true
git config --global core.editor vim
