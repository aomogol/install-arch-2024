#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################
## Monster Notebook için denendi
echo
tput setaf 3
echo "################################################################"
echo "################### TUXEDO software install "
echo "################################################################"
tput sgr0
echo

list=(
tuxedo-control-center-bin 
)
# tuxedo-keyboard-tools

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
    	yay -S --noconfirm --needed $1
    fi
}

###############################################################################
echo "Installation Complete"
###############################################################################
count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done






