#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################

#sudo nano /etc/default/grub 
# başında '#' var ise kaldırılacak ' GRUB_DISABLE_OS_PROBER=false

# Önce satırın var olup olmadığını kontrol et
if grep -q "^#GRUB_DISABLE_OS_PROBER=false" /etc/default/grub; then
    # Eğer satır varsa ve başında # işareti varsa, # işaretini kaldır
    sudo sed -i 's/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
    echo "GRUB_DISABLE_OS_PROBER=false satırının başındaki # işareti kaldırıldı."
elif grep -q "^GRUB_DISABLE_OS_PROBER=false" /etc/default/grub; then
    # Eğer satır zaten aktifse, kullanıcıya bilgi ver
    echo "GRUB_DISABLE_OS_PROBER=false satırı zaten aktif."
else
    # Eğer satır yoksa, yeni bir satır ekle
    echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub > /dev/null
    echo "GRUB_DISABLE_OS_PROBER=false satırı eklendi."
fi

sudo update-grub
# yada
# sudo grub-mkconfig -o /boot/grub/grub.cfg
