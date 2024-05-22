#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################
echo
tput setaf 3
echo "################################################################"
echo "################### Firmware software install "
echo "################################################################"
tput sgr0
echo

yay -S --noconfirm --needed upd72020x-fw wd719x-firmware aic94xx-firmware lshw  hwinfo linux-firmware-qlogic
# hw-probe
###############################################################################
echo "Installation Complete"
###############################################################################

echo "################### Logitech MX Mouse"
# yay -S --noconfirm --needed logiops