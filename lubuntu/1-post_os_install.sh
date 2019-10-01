
# =============================================================================
# VirtualBox
# =============================================================================
read -p "--- INSERT GUEST ADDITIONS CD IMAGE --- " done; done=${done:-"yes"}
sudo get install -y make gcc linux-headers-$(uname -r)
sudo mkdir /media/cdrom
sudo mount /dev/cdrom /media/cdrom
sudo /media/cdrom/VBoxLinuxAdditions.run
sudo usermod -aG vboxsf $(whoami)
shutdown -r now