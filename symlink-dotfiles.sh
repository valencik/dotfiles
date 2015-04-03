#!/bin/bash -e

# Symlink dotfiles to home folder
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.zshenv ~/.zshenv
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.hammerspoon ~/.hammerspoon
