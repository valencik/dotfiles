#!/bin/bash
# Bootstrap a clean OS X install

# Define mesage output types and colours
ERROR="$(tput setaf 1)ERROR:$(tput sgr 0)"
BOOTSTRAP="$(tput setaf 2)BOOTSTRAP:$(tput sgr 0)"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "${BOOTSTRAP} Installing xcode command line tools - May require user interaction"
sudo xcode-select --install
read -p "${BOOTSTRAP} Press any key when Xcode install completes"

echo "${BOOTSTRAP} Installing homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update

echo "${BOOTSTRAP} Installing formulae and casks from .brewfile..."
xargs <brewlist.txt brew install
brew cleanup

echo "${BOOTSTRAP} Installing oh-my-zsh"
curl -L http://install.ohmyz.sh | sh

echo "${BOOTSTRAP} Installing python libraries from .pipfile..."
pip3 install --upgrade -r .pipfile

echo "${BOOTSTRAP} Running .gitsetup script..."
./.gitsetup

echo "${BOOTSTRAP} Running .dock script..."
./.dock

echo "${BOOTSTRAP} Running .osx script..."
./.osx
