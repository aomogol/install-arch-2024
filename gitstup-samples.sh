#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
# Description: Bu script, Git ve SSH ayarlarını yapılandırır
#              ve gerekli araçları yükler.
#######################################################



# set name and email
git config --global user.name "aomogol"
git config --global user.email "aomogol@gmail.com"

# set default branch name (optional)
git config --global init.defaultBranch main
