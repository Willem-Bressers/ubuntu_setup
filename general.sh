# add user to virtualbox
sudo adduser $(whoami) vboxsf

# update ubuntu
sudo apt update -y
sudo apt upgrade -y

# install java
sudo apt install default-jre

# install vim
sudo apt install vim -y

# install sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update -y
sudo apt install sublime-text

# install git
sudo apt install git -y
git config --global user.email "info@willembressers.nl"
git config --global user.name "Willem Bressers"
git config --global core.editor "vim"
git config --global push.default simple
git config --global core.excludesfile ~/.gitignore
touch ~/.gitignore

# setup ssh
ssh-keygen -t rsa -b 4096 -C "info@willembressers.nl"
cat ~/.ssh/id_rsa.pub