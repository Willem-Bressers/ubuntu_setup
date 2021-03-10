# https://askubuntu.com/questions/426750/how-can-i-update-my-nodejs-to-the-latest-version

# install npm for jupyter lab extensions
sudo apt install -y npm

sudo npm cache clean -f
sudo npm install -g n
sudo n stable

# fix /usr/bin/node
# sudo apt-get install --reinstall nodejs-legacy