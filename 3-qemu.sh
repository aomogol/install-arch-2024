#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################
echo
tput setaf 3
echo "################################################################"
echo "###################  install qemu "
echo "################################################################"
tput sgr0
echo

# iptables-nft kurmak için var ise iptables kaldırılmalı
if sudo pacman -Qs iptables-nft > /dev/null ; then
    echo ":: iptables-nft is already installed!"
else
    echo ":: iptables-nft is not installed. Remove iptables"
		yay -Rdd iptables --noconfirm
    echo ":: yay has been installed successfully."
fi

list=(
iptables-nft
ebtables
qemu-full
virt-manager
virt-viewer
dnsmasq
vde2
bridge-utils
edk2-ovmf
dmidecode
)
#qemu-desktop
#spice-vdagent
#xf86-video-qxl

func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
		#sudo pacman -S --noconfirm --needed $1
		yay -S --needed --noconfirm $1
    fi
}

###############################################################################
echo "Installation "
###############################################################################
count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done



#tutorial https://www.youtube.com/watch?v=JxSGT_3UU8w
#https://computingforgeeks.com/install-kvm-qemu-virt-manager-arch-manjar/
## Search for Kernel Module
## zgrep CONFIG_KVM /proc/config.gz
LC_ALL=C lscpu | grep Virtualization
# grep -E --color=auto 'vmx|svm|0xc0f' /proc/cpuinfo
lsmod | grep kvm

if ! grep -q "options kvm-intel nested=1" /etc/modprobe.d/kvm-intel.conf; then
	echo 'options kvm-intel nested=1' | sudo tee -a /etc/modprobe.d/kvm-intel.conf
fi
sleep 3

sudo gpasswd -a $USER libvirt
sudo gpasswd -a $USER kvm
#starting service
sleep 2
sudo systemctl enable --now libvirtd.service
sleep 3
# sudo systemctl start libvirtd.service

# if ! grep -q "nvram = ["/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd"]" /etc/libvirt/qemu.conf; then
#	echo 'nvram = ["/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd"]' | sudo tee -a /etc/libvirt/qemu.conf
# fi
# echo 'nvram = ["/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd"]' | sudo tee --append /etc/libvirt/qemu.conf

sudo virsh net-define /etc/libvirt/qemu/networks/default.xml
sleep 5
sudo virsh net-autostart default
sleep 5
sudo systemctl restart libvirtd.service


echo "################### QEMU - Done "
echo "################################################################"


### Intel Processor ###
# sudo modprobe -r kvm_intel
# sudo modprobe kvm_intel nested=1


# Open the file /etc/libvirt/libvirtd.conf for editing.

# sudo nano  /etc/libvirt/libvirtd.conf
# Set the UNIX domain socket group ownership to libvirt, (around line 85)

# unix_sock_group = "libvirt"

# Set the UNIX socket permissions for the R/W socket (around line 102)

# unix_sock_rw_perms = "0770"

# Add your user account to libvirt group.
#  sudo usermod -a -G libvirt $(whoami)
# newgrp libvirt
#  Restart libvirt daemon.
