#!/bin/sh

# Install Ansible
if ! (type git >/dev/null 2>&1); then
  echo "Installing git"
  sudo apt-get install git -y >/dev/null
fi

git clone https://github.com/logica0419/dotfiles.git

cd dotfiles || return 1
sh ./run.sh
