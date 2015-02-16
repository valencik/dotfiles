#!/bin/bash
# Bootstrap a clean OS X install

# Define mesage output types and colours
ERROR="$(tput setaf 1)ERROR:$(tput sgr 0)"
BOOTSTRAP="$(tput setaf 2)BOOTSTRAP:$(tput sgr 0)"

echo "${BOOTSTRAP} Installing xcode command line tools - May require user interaction"
sudo xcode-select --install
read -p "${BOOTSTRAP} Press any key when Xcode install completes"

echo "${BOOTSTRAP} Installing homebrew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update

echo "${BOOTSTRAP} Installing formulae and casks from .brewfile..."
brew brewdle

echo "${BOOTSTRAP} Installing python libraries from .pipfile..."
pip3 install --upgrade -r .pipfile

echo "${BOOTSTRAP} Running .osx script..."
./.osx

echo "${BOOTSTRAP} Running .gitconfig script..."
./.gitconfig
