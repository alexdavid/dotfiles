#!/bin/bash

cd

# Create symlinks
ln -s .config/bash/bashconfig .bash_profile
ln -s .config/bash/bashconfig .bashrc
ln -s .config/git/gitconfig   .gitconfig
ln -s .config/tmux/tmux.conf  .tmux.conf
ln -s .config/vim/vimrc       .vimrc

# Create hushlogin
touch .hushlogin


# Prompt for name and email for git commits
full_name=$(finger $(whoami) | sed -e '/Name/!d;s/.*: //')
read -p "Enter your name for git commits ($full_name): " git_user
read -p "Enter your email for git commits: " git_email

if [ -z "$git_user" ]
then
   git_user=$full_name
fi

git config --global user.name "$git_user"
git config --global user.email "$git_email"


cd ~/.config

# Prevent git from showing new name/email changes in gitconfig
git update-index --assume-unchanged git/gitconfig

# Install vim plugins
git submodule init
git submodule update
git submodule foreach git checkout master
vim +BundleInstall! +qall
