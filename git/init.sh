#!/usr/bin/env sh

# Create symlinks
ln -s .config/git/gitconfig ~/.gitconfig


# Prompt for name and email for git commits
full_name=$(finger $(whoami) | sed -e '/Name/!d;s/.*: //')
read -p "Enter your name for git commits ($full_name): " git_user
read -p "Enter your email for git commits: " git_email

if [ -z "$git_user" ]; then
   git_user=$full_name
fi

echo "[user]" > ~/.config/git/gitconfig_user
echo "  name = $git_user" >> ~/.config/git/gitconfig_user
echo "  email = $git_email" >> ~/.config/git/gitconfig_user
