# install git
sudo apt install -y git vim git-flow

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

# generate ssh key
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -b 4096 -C "dhr.bressers@gmail.com"
fi

# new key
echo -e "\e[31mssh key =\e[0m $(cat ~/.ssh/id_rsa.pub)"