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
figlet "Pacman"
echo "########## /etc/pacman.conf >>  color & paralel download"
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
    git
    wget
    curl
    neofetch
    fastfetch

    partitionmanager
    gparted
    timeshift
    os-prober
    ventoy-bin

    btop
    htop

    #paru-bin
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

    dolphin
    dolphin-plugins
    unzip
    p7zip
    ffmpegthumbs
    kimageformats
    kdegraphics-thumbnailers
    poppler-glib
    gdk-pixbuf2
    plocate

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
    simplescreenrecorder
    svgpart
    gwenview
    yuki-iptv-bin

    starship
    zoxide
    fzf
    zsh
    eza

    kdeconnect

    zoom

    archiso
    downgrade
    caffeine-ng

    visual-studio-code-bin 
    sublime-text-4 
    meld
    github-cli 
    github-desktop-bin

    gearlever
    stow
    neohtop
    ipscan
    onefetch
    lm_sensors
    diskmonitor
    youtube-music-bin
    zerotier-one
    obsidian
    grsync
    linutil-bin
    hugo
    remmina
    remmina-plugin-folder
    remmina-plugin-rdesktop
    freerdp
    xrdp
    hfsutils
    exfat-utils
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


# Get the current Linux kernel version
figlet "Kernel"
kernel_version=$(uname -r)
echo "Current Linux kernel version: $kernel_version"

# Determine the kernel type (e.g., linux, linux-zen, linux-lts)
if [[ $kernel_version == *"zen"* ]]; then
    kernel_type="linux-zen"
elif [[ $kernel_version == *"lts"* ]]; then
    kernel_type="linux-lts"
else
    kernel_type="linux"
fi
echo "Kernel type: $kernel_type"

# Install Linux headers package
sudo pacman -S "${kernel_type}-headers" --noconfirm --needed

# ------------------------------------------------------
# Check for Bluetooth, install Pipewire-compatible packages and enable service if available
# ------------------------------------------------------
figlet "Bluetooth"
if [[ $(lsmod | grep btusb) ]]; then
    echo "Bluetooth hardware detected. Installing Pipewire-compatible Bluetooth packages and enabling service..."
    
    # Install Pipewire and Bluetooth packages
    bluetooth_packages=(
        pipewire
        pipewire-pulse
        pipewire-alsa
        pipewire-jack
        wireplumber
        bluez
        bluez-utils
        blueman
    )
    
    for package in "${bluetooth_packages[@]}"; do
        if ! yay -Qi "$package" &> /dev/null; then
            yay -S  --needed "$package"
        else
            echo "$package is already installed."
        fi
    done
    
    # Enable and start Bluetooth service
    sudo systemctl enable --now bluetooth.service
    
    # Ensure Pipewire service is running
    systemctl --user enable --now pipewire.service
    systemctl --user enable --now pipewire-pulse.service
    
    echo "Pipewire and Bluetooth packages installed and services enabled."
else
    echo "No Bluetooth hardware detected. Skipping Bluetooth setup."
fi


figlet "DONE.... REBOOT"
