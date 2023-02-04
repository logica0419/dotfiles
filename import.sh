#!/bin/sh

# Install Git
if ! (type git >/dev/null 2>&1); then
  echo "Installing git"
  sudo apt-get update
  sudo apt-get install git -y >/dev/null
fi

if [ ! -d dotfiles ]; then
  git clone https://github.com/logica0419/dotfiles.git
fi

cd dotfiles || return 1
sh ./run.sh
