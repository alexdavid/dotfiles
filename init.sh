#!/bin/bash

cd

# Create symlinks
ln -s .config/bin .bin
ln -s .config/bash/bashconfig .bash_profile
ln -s .config/bash/bashconfig .bashrc
ln -s .config/git/gitconfig .gitconfig
ln -s .config/tmux/tmux.conf .tmux.conf

# Create hushlogin
touch .hushlogin


# Prompt for name and email for git commits
read -p "Enter your name for git commits: " git_user
read -p "Enter your email for git commits: " git_email
git config --global user.name "$git_user"
git config --global user.email "$git_email"
