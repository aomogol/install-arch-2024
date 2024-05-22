#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################


echo -e "${GREEN}"
    figlet "Install DOCKER Packages"
echo -e "${NONE}"

# ------------------------------------------------------
# List of packages to install
# ------------------------------------------------------
#
packages=(

    visual-studio-code-bin
    sublime-text-4
    github-cli
    github-desktop-bin

    )

# ------------------------------------------------------
# Install packages using yay
# ------------------------------------------------------
#
for package in "${packages[@]}"; do
    if yay -Qi "$package" &> /dev/null; then
        tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1 - $package " is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
    else
       	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1 - $package
    	echo "###############################################################################"
    	echo
    	tput sgr0
        yay -S --noconfirm --needed "$package"
    fi
done

    tput setaf 3
    echo "###############################################################################"
    echo "##################  All packages installed successfully."
    echo "###############################################################################"
    echo
    tput sgr0

# ------------------------------------------------------
# Docker install
# ------------------------------------------------------
#sudo groupadd docker
#newgrp docker

figlet "DOCKER "

sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl enable containerd.service
sudo systemctl start containerd.service
sudo chmod 666 /var/run/docker.sock
#docker run hello-world
docker ps -a
