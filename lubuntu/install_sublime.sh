#! /bin/bash

# =============================================================================
# Ubuntu packages resources
# =============================================================================
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# =============================================================================
# Ubuntu packages
# =============================================================================
sudo apt update -y
sudo apt install -y sublime-text

# =============================================================================
# Ubuntu packages
# =============================================================================
echo "EDITOR=$(which subl)" >> ~/.pam_environment
echo "*.sublime-project" >> ~/.gitignore
echo "*.sublime-workspace" >> ~/.gitignore