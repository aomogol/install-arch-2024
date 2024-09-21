#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
#######################################################


git config --global user.name "A Onder Mogol"
git config --global user.email aomogol@gmail.com

# Kimlik bilgilerini önbelleğe alma
git config --global credential.helper cache

# İsteğe bağlı: Önbellek süresini ayarlama (örneğin, 1 saat için = 3600)
git config --global credential.helper 'cache --timeout=36000'

