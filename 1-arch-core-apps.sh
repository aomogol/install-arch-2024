#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################
sudo pacman -S --needed --noconfirm figlet

# ------------------------------------------------------
# Check if yay is installed
# ------------------------------------------------------
echo -e "${GREEN}"
    figlet "yay"
echo -e "${NONE}"
if sudo pacman -Qs yay > /dev/null ; then
    echo ":: yay is already installed!"
else
    echo ":: yay is not installed. Starting the installation!"
    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")
    echo $temp_path
    git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin
    cd ~/yay-bin
    makepkg -si
    cd $temp_path
    echo ":: yay has been installed successfully."
fi
echo ""
# ------------------------------------------------------
# Pacman.conf file
# ------------------------------------------------------
echo "########## /etc/pacman.conf >>  color - paralel download"
# sudo nano /etc/pacman.conf
echo "Pacman parallel downloads set to 20"
	FIND="#ParallelDownloads = 5"
	REPLACE="ParallelDownloads = 20"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

echo "Color"
	FIND="#Color"
	REPLACE="Color"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

# ------------------------------------------------------
# Updates
# ------------------------------------------------------
yay -Syyu --noconfirm

echo -e "${GREEN}"
    figlet "Install Packages"
echo -e "${NONE}"

# ------------------------------------------------------
# List of packages to install
# ------------------------------------------------------
#
packages=(
    base-devel
    linux-headers
    git
    wget
    curl
    meld
    neofetch
    fastfetch

    partitionmanager
    gparted
    timeshift
    os-prober

    btop
    htop

    paru-bin
    pkgcacheclean
    pacman-contrib
    reflector
    rate-mirrors-bin

    gvfs-mtp
    ntfs-3g
    nfs-utils
    cifs-utils
    dosfstools
    usbutils
    exfatprogs
    udftools
    xfsprogs
    mtools
    btrfs-progs

    dolphin-plugins
    unzip
    p7zip

    ttf-meslo-nerd
    ttf-meslo-nerd-font-powerlevel10k
    powerline-fonts
    ttf-ms-fonts
    awesome-terminal-fonts
    ttf-ubuntu-font-family
    ttf-hack
    ttf-roboto
    adobe-source-sans-fonts

    bat
    starship
    tldr
    ncdu
    duf

    thorium-browser-bin
    google-chrome
    brave-bin
    filezilla
    firefox
    qbittorrent

    onlyoffice-bin
    thunderbird

    net-tools
    traceroute
    networkmanager-openvpn
    bind
    dnsdiag
    netplan

    grub-customizer
    update-grub
    gnome-firmware
    inxi
    rsync
    syncthing
    ripgrep
    trash-cli

    vlc
    spotify
    aribb24
    spectacle
    simplescreenrecorder-bin
    svgpart
    gwenview

    starship
    zoxide
    fzf
    zsh

    kdeconnect

    zoom

    archiso
    downgrade
    caffeine-ng

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

# ------------------------------------------------------
# All packages installed
# ------------------------------------------------------
#
    tput setaf 3
    echo "###############################################################################"
    echo "##################  All packages installed successfully."
    echo "###############################################################################"
    echo
    tput sgr0

# ------------------------------------------------------
# determine processor type and install microcode
# ------------------------------------------------------
figlet "Microcode"
echo "Installing Intel microcode"
proc_type=$(lscpu | awk '/Vendor ID:/ {print $3}')
case "$proc_type" in
	GenuineIntel)
		echo "Installing Intel microcode"
		yay -S --needed --noconfirm intel-ucode
		proc_ucode=intel-ucode.img
		;;
	AuthenticAMD)
		echo "Installing AMD microcode"
		yay -S --needed --noconfirm amd-ucode
		proc_ucode=amd-ucode.img
		;;
esac


