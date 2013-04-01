#!/bin/bash

# Exit on error
set -e
cd

# Backup existing files
backup_dir="dotfiles_backup"
mkdir $backup_dir

for i in \
  "bash"\
  "bin"\
  "bash_profile"\
  "bashrc"\
  "config"\
  "git"\
  "gitconfig"\
  "gitignore_global"\
  "hushlogin"
do
  if [ -e ".$i" ]; then
    echo -e "\e[1;31mMoving .$i to $backup_dir/$i\e[m"
    mv ".$i" "$backup_dir/$i"
  fi
done


# Pull down repo
git init
git remote add origin git://github.com/alexdavid/dotfiles.git
git fetch
git branch master origin/master
git checkout master


# Move readme & init.sh to the backup folder
mv README.md dotfiles_backup/
mv init.sh dotfiles_backup/
