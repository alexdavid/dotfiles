#!/usr/bin/env bash

echo
echo "Testing if you have access to clone GitHub projects over SSH..."
if (ssh git@github.com 2>&1 | grep "You've successfully authenticated, but GitHub does not provide shell access"); then
  echo "Success! Proceding over SSH"
  ORIGIN="git@github.com:alexdavid/dotfiles.git"
else
  echo "Failed! Proceding over HTTP"
  ORIGIN="https://github.com/alexdavid/dotfiles.git"
fi

echo
echo "Checking for existence of ~/.config directory"
if [ -e ~/.config ]; then
  echo "~/.config already exists! (Re)move it before running this script"
  echo
  exit 1
fi

echo
echo "Cloning dotfiles"
git clone $ORIGIN ~/.config

echo
echo "Initializing"
~/.config/init.sh
