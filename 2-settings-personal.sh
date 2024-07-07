#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################

# ------------------------------------------------------
# User groups
# ------------------------------------------------------
echo "User Groups "
# EDITOR=nano sudo -E visudo
sudo usermod -aG wheel $USER
sudo usermod -aG users,power,lp,adm,audio,video,optical,storage,network,rfkill $USER


# ------------------------------------------------------
# Mirror List yenileme
# ------------------------------------------------------
    tput setaf 3
    echo "###############################################################################"
    echo "################## Mirror List yenileme"
    echo "###############################################################################"
    echo
    tput sgr0
sudo reflector --latest 10  --fastest 10 --sort rate --protocol http,https --save /etc/pacman.d/mirrorlist

# rate- mirrors
# export TMPFILE="$(mktemp)"; \
    # sudo true; \
    # rate-mirrors --save=$TMPFILE arch --max-delay=43200 \
    # && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
    # && sudo mv $TMPFILE /etc/pacman.d/mirrorlist

    echo
    tput setaf 3
    echo "################################################################"
    echo "###################  Mirrorlist yenilendi "
    echo "################################################################"
    tput sgr0


# ------------------------------------------------------
# # Syncthing service
# ------------------------------------------------------
# sudo systemctl enable --now syncthing@aom.service

# ------------------------------------------------------
### services enable
# ------------------------------------------------------
# sudo systemctl enable --now avahi-daemon.service
# sudo systemctl enable bluetooth


echo "################### Personal settings to install - "
installed_dir=$(dirname $(readlink -f $(basename `pwd`)))
	echo "Installing all shell files"
	echo
	cp $installed_dir/settings/shell-personal/.bashrc ~/.bashrc
	cp $installed_dir/settings/shell-personal/.bashrc-personal ~/.bashrc-personal
	cp $installed_dir/settings/shell-personal/.bash_profile ~/.bash_profile
	cp $installed_dir/settings/shell-personal/.aom_prompt ~/.aom_prompt
	cp $installed_dir/settings/shell-personal/.gitconfig ~/.gitconfig
	cp $installed_dir/settings/shell-personal/excludes.txt ~/excludes.txt
	cp $installed_dir/settings/shell-personal/serverList.txt ~/serverList.txt


#                                                       ### Switch to ZSH
#sudo chsh $USER -s /bin/zsh
#sudo usermod -s /bin/zsh $USER

echo
#echo "################### Personal settings to install - "

echo "Sublime text settings"
echo
#The exact details of the symlink command will depend on the installation location. 
    #Most default PATH environment variable values should contain /usr/local/bin, 
        # so no further commands should be necessary.
sudo ln -s /opt/sublime_text/sublime_text /usr/local/bin/subl

## set your EDITOR environment variable:
    # export EDITOR='subl -w'


#[ -d $HOME"/.config/sublime-text/Packages/User" ] || mkdir -p $HOME"/.config/sublime-text/Packages/User"
#cp  $installed_dir/settings/sublimetext/Preferences.sublime-settings $HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings
echo "Sublime text settings done"

