#!/bin/bash

cd

# Backup existing files
mkdir dotfiles_backup
mv .bash_profile dotfiles_backup/bash_profile
mv .gitmodules dotfiles_backup/gitmodules
mv .bashrc dotfiles_backup/bashrc
mv .vimrc dotfiles_backup/vimrc
mv .vim dotfiles_backup/vim
mv .git dotfiles_backup/git

# Pull down repo
git init
git remote add origin git@github.com:alexdavid/dotfiles.git
git fetch
git branch master origin/master
git checkout master

# Pull git submodules recursively
git submodule update --init --recursive


# Move readme & init.sh to the backup folder
mv readme dotfiles_backup/
mv init.sh dotfiles_backup/
