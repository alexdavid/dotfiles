#!/usr/bin/env sh

# Create symlinks
ln -s .config/vim/vimrc ~/.vimrc

# Install vim plugins
vim +BundleInstall! +qall
