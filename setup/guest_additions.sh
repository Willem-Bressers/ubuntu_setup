# update OS
sudo apt update
sudo apt upgrade

# install OS packages
sudo apt-get install -y build-essential dkms linux-headers-$(uname -r)

read -p "--- INSERT GUEST ADDITIONS CD IMAGE --- " done; done=${done:-"yes"}

# mount the cdrom
sudo mount /dev/cdrom /mnt

# run the  virtualbox additions script
sudo /mnt/VBoxLinuxAdditions.run

# add the user to the vboxsf group
sudo usermod -aG vboxsf $USER

# reboot
shutdown -r now