#!/usr/bin/env sh

touch ~/.hushlogin

cd ~/.config
git submodule init
git submodule update
git submodule foreach git checkout master

~/.config/bash/init.sh
~/.config/git/init.sh
~/.config/tmux/init.sh
~/.config/vim/init.sh
~/.config/zsh/init.sh
