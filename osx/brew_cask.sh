#!/bin/bash

brew tap phinze/homebrew-cask
brew install brew-cask

brew cask install \
  adium \
  divvy \
  dropbox \
  google-chrome \
  hipchat \
  iterm2 \
  macvim \
  qlcolorcode \
  qlstephen \
  sequel-pro \
  true-crypt \
  vlc

# Hide opt folder that brew cask creates
sudo chflags hidden /opt
