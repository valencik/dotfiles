#!/bin/bash -e

# Change to home directory
cd $HOME

# Get the dotfiles in place
curl -fsSLO https://github.com/valencik/dotfiles/archive/master.zip
unzip master.zip; rm master.zip
rsync --exclude-from 'rsync-excludes.txt' -avh --no-perms dotfiles-master/ ~;
