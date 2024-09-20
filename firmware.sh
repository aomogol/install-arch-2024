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

# Gerekli firmware ve donanım bilgi araçlarını kur
# upd72020x-fw: USB 3.0 kontrolcüsü için firmware
# wd719x-firmware: Western Digital SCSI kartları için firmware
# aic94xx-firmware: Adaptec SAS/SATA kontrolcüsü için firmware
# lshw: Donanım bilgilerini listelemek için araç
# hwinfo: Donanım bilgilerini almak için araç
# linux-firmware-qlogic: QLogic ağ kartları için firmware
# hw-probe: Donanım ve yazılım bilgilerini toplamak ve teşhis etmek için araç
yay -S --noconfirm --needed upd72020x-fw wd719x-firmware aic94xx-firmware lshw hwinfo linux-firmware-qlogic 

## hw-probe
###############################################################################
echo "Installation Complete"
###############################################################################

echo "################### Logitech MX Mouse"
# yay -S --noconfirm --needed logiops