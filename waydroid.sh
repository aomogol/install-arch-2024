#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################


yay -S --needed --noconfirm waydroid  binder_linux-dkms

sudo waydroid init
sudo waydroid start
echo "Please log in to your Waydroid session"