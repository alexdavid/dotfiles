#!/usr/bin/env sh

# Create symlinks
ln -s .config/vim/vimrc ~/.vimrc

# Install vim plugins
mkdir ~/.config/vim/plug.vim
curl -fLo ~/.config/vim/plug.vim/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
