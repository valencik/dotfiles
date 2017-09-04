#!/bin/bash -e

# Symlink dotfiles to home folder
mv ~/.zshrc ~/.zshrc_backup
ln -s $(pwd)/bin ~/bin
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.zshenv ~/.zshenv
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/sunrise-w-job-count.zsh-theme ~/.oh-my-zsh/themes/sunrise-w-job-count.zsh-theme
