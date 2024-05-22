#!/bin/bash
#set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

echo "######################################"
echo "Setting up ZSH With p10k & OMZ Plugins"
echo "######################################"
sleep 2
echo "Step 1 - Grabing Necessary Fonts"
echo "################################"
yay -S --needed --noconfirm  zsh grml-zsh-config
#sudo pacman -S --needed --noconfirm zsh grml-zsh-config
yay -S --needed --noconfirm ttf-meslo-nerd siji-git ttf-unifont noto-color-emoji-fontconfig xorg-fonts-misc ttf-dejavu ttf-meslo-nerd-font-powerlevel10k noto-fonts-emoji powerline-fonts zsh-theme-powerlevel10k
sleep 2
echo "Step 2 - Grabing OhMyZsh & Plugins"
echo "##################################"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sleep 2
echo "Step 3 - Grabing PowerLevel10k Theme"
echo "#####################################"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cd $HOME/ && cp $installed_dir/settings/shell-personal/.p10k.zsh $HOME/.p10k.zsh
# wget https://raw.githubusercontent.com/aomogol/after-arch-install/main/settings/shell-personal/.p10k.zsh
# wget https://raw.githubusercontent.com/xerolinux/xero-fixes/main/conf/.p10k.zsh

sleep 2
echo "Step 4 - Setting Default Shell to ZSH"
echo "#####################################"
sudo chsh $USER -s /bin/zsh

[ -d $HOME"/.local/share/konsole" ] || mkdir -p $HOME"/.local/share/konsole"
cp  $installed_dir/settings/konsole/* $HOME/.local/share/konsole
cd $HOME/.local/share/konsole/
sed -i 's|/bin/bash|/bin/zsh|g' Anatolia.profile
sleep 2
echo "Step 5 - Importing Anatolia .zshrc"
echo "#####################################"
cd $HOME/
rm .zshrc
# wget https://raw.githubusercontent.com/aomogol/after-arch-install/main/settings/shell-personal/.zshrc
# wget https://raw.githubusercontent.com/xerolinux/xero-fixes/main/conf/.zshrc
cp $installed_dir/settings/shell-personal/.zshrc $HOME/.zshrc

sleep 2
echo "#####################################"
echo "     Done ! Now Logout & back in     "
echo "#####################################"
