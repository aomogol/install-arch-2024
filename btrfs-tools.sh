#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################


# ------------------------------------------------------
# BTRFS 
# ------------------------------------------------------
# 
echo "################################################################"
echo "################### Btrfs"
echo "################################################################"
if 	lsblk -f | grep btrfs > /dev/null 2>&1 ; then
	echo "################################################################"
	echo "################### Snapper to be installed"
	echo "################################################################"
	echo "You are using BTRFS. Installing the software ..."
	echo
	yay -S --needed --noconfirm snapper
	yay -S --needed --noconfirm grub-btrfs
	yay -S --needed --noconfirm btrfs-assistant
	yay -S --needed --noconfirm snap-pac
	yay -S --needed --noconfirm snapper-support
	#yay -S --needed --noconfirm btrfsmaintenance

	echo "################################################################"
	echo "################### Snapper installed"
	echo "################################################################"
else
	echo "################################################################"
	echo "### Your harddisk/ssd/nvme is not formatted as BTRFS."
	echo "### Packages will not be installed."
	echo "################################################################"
fi
