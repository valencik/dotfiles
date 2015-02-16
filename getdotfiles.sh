#!/bin/bash -e

# Change to home directory
cd $HOME

# Get the dotfiles in place
curl -fsSLO https://github.com/valencik/dotfiles/archive/master.zip
unzip master.zip; rm master.zip
rsync --exclude ".git" --exclude "README.md" --exclude "bootstrap.sh" \
    --exclude "getdotfiles.sh" -avh --no-perms dotfiles-master/ ~;
