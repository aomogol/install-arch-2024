#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################


sudo pacman -S --needed --noconfirm mesa xf86-video-amdgpu


### To install support for Vulkan API (will be functional only if you have a Vulkan capable GPU) and 32-bit games, execute following command:
### https://github.com/lutris/docs/blob/master/InstallingDrivers.md#arch--manjaro--other-arch-linux-derivatives

## sudo pacman -S --needed --noconfirm lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader

## Xero Linux 
yay -S --needed --noconfirm xf86-video-amdgpu libvdpau-va-gl vulkan-swrast 
yay -S --needed --noconfirm libva-vdpau-driver libclc vulkan-radeon 
yay -S --needed --noconfirm lib32-vulkan-radeon lib32-amdvlk amdvlk vulkan-icd-loader lib32-vulkan-icd-loader 
yay -S --needed --noconfirm egl-wayland

sudo mkinitcpio -P

#### GAMING Setup

### https://www.reddit.com/r/linux_gaming/comments/knu89x/how_to_set_up_arch_linux_for_gaming_nvidia_intel/

### Wine's dependencies 
## https://github.com/lutris/docs/blob/master/WineDependencies.md#archantergosmanjaroother-arch-derivatives

sudo pacman -S --needed --noconfirm wine giflib lib32-giflib libpng 
sudo pacman -S --needed --noconfirm lib32-libpng libldap lib32-libldap 
sudo pacman -S --needed --noconfirm gnutls lib32-gnutls mpg123 lib32-mpg123 
sudo pacman -S --needed --noconfirm openal lib32-openal v4l-utils lib32-v4l-utils 
sudo pacman -S --needed --noconfirm libpulse lib32-libpulse libgpg-error lib32-libgpg-error 
sudo pacman -S --needed --noconfirm alsa-plugins lib32-alsa-plugins alsa-lib 
sudo pacman -S --needed --noconfirm lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo 
sudo pacman -S --needed --noconfirm sqlite lib32-sqlite libxcomposite lib32-libxcomposite 
sudo pacman -S --needed --noconfirm libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama 
sudo pacman -S --needed --noconfirm ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt 
sudo pacman -S --needed --noconfirm lib32-libxslt libva lib32-libva 
sudo pacman -S --needed --noconfirm gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs 
sudo pacman -S --needed --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader

### wine-staging  kullanılmıyor artık bakılacak

yay -S --needed --noconfirm gamemode gvfs innoextract lib32-gamemode 
yay -S --needed --noconfirm lib32-vkd3d python-protobuf vkd3d vulkan-tools
yay -S --needed --noconfirm winetricks protontricks


sudo pacman -S --needed --noconfirm steam
sudo pacman -S --needed --noconfirm lutris


## Proton GE Custom
### https://github.com/GloriousEggroll/proton-ge-custom
