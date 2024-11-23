

sudo pacman -Syyu
sudo pacman -S --needed plasma-desktop 
sudo pacman -S --needed plasma-meta
sudo pacman -S --needed plasma-nm plasma-pa dolphin konsole kdeplasma-addons kde-gtk-config breeze-gtk 

sudo systemctl enable NetworkManager
sudo systemctl enable sddm

