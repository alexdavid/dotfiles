#!/usr/bin/env sh

# Create symlinks
ln -s .config/tmux/tmux.conf ~/.tmux.conf

# Install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/tpm
