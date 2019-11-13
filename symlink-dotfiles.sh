#!/usr/bin/env -S bash -e

# Symlink dotfiles to home folder
ln -s $(pwd)/bin ~/bin
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
