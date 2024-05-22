#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################
echo
tput setaf 3
echo "################################################################"
echo "###################  install "
echo "################################################################"
tput sgr0
echo

list=(
ttf-meslo-nerd-font-powerlevel10k
powerline-fonts
ttf-ms-fonts
awesome-terminal-fonts
ttf-ubuntu-font-family
ttf-hack
ttf-roboto
adobe-source-sans-fonts
)

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
echo "Installation Complete"
###############################################################################
count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done




#echo "################### fonts"
#yay -S --needed --noconfirm ttf-meslo-nerd-font-powerlevel10k
#yay -S --needed --noconfirm powerline-fonts
#yay -S --needed --noconfirm ttf-ms-fonts
#yay -S --needed --noconfirm awesome-terminal-fonts
#yay -S --needed --noconfirm ttf-ubuntu-font-family
#yay -S --needed --noconfirm ttf-hack
#yay -S --needed --noconfirm ttf-roboto
#yay -S --needed --noconfirm adobe-source-sans-fonts
#yay -S --needed --noconfirm ttf-fantasque-sans-mono 
#yay -S --needed --noconfirm ttf-iosevka-nerd 
#yay -S --needed --noconfirm ttf-material-design-iconic-font 
#yay -S --needed --noconfirm ttf-sourcecodepro-nerd 
#yay -S --needed --noconfirm ttf-hack ttf-roboto   
#yay -S --needed --noconfirm ttf-bitstream-vera 
#yay -S --needed --noconfirm ttf-dejavu 
#yay -S --needed --noconfirm ttf-droid 
#yay -S --needed --noconfirm ttf-inconsolata 
#yay -S --needed --noconfirm ttf-liberation 
#yay -S --needed --noconfirm ttf-roboto-mono 
#yay -S --needed --noconfirm noto-fonts 