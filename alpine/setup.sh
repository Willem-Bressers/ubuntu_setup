# Vanilla Alpine installation on Virtual Box

# https://guglio.xyz/virtualbox-alpine-enable-shared-folders/

# install guest additions
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
apk update
apk add \
	virtualbox-guest-additions \
	virtualbox-guest-additions-openrc\
	virtualbox-guest-modules-vanilla \
	virtualbox-guest-modules-virt
reboot now

modprobe -a vboxsf
mkdir /mnt/shared
mount -t vboxsf shared /mnt/shared



apk add mate-desktop-environment