#!/bin/bash

# Exit on error
set -e
cd

# Backup existing files
backup_dir="dotfiles_backup"
mkdir $backup_dir

for i in \
  "bin"\
  "bash_profile"\
  "bashrc"\
  "config"\
  "git"\
  "gitconfig"\
  "hushlogin"\
  "tmux.conf"
do
  if [ -e ".$i" ]; then
    echo -e "[1;31mMoving .$i to $backup_dir/$i[m"
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
rm ~/README.md
rm ~/init.sh
rm -rf ~/.git
