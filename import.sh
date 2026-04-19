#!/bin/bash
set -e

# Install Git
if ! command -v git &>/dev/null; then
  echo "Installing git"
  sudo apt-get update
  sudo apt-get install git -y &>/dev/null
fi

if [ ! -d dotfiles ]; then
  git clone https://github.com/logica0419/dotfiles.git
fi

cd dotfiles || return 1
# shellcheck source=/dev/null
source ./run.sh
