#!/bin/bash
set -e

if [ "$PWD" != "$HOME" ]; then
  echo "Error: import.sh must be run in $HOME (current: $PWD)" >&2
  exit 1
fi

if ! command -v git &> /dev/null; then
  echo "Installing git"
  sudo apt-get update
  sudo apt-get install git -y &> /dev/null
fi

if [ -e dotfiles ]; then
  echo "Error: $HOME/dotfiles already exists" >&2
  exit 1
fi

git clone https://github.com/logica0419/dotfiles.git

cd dotfiles || return 1
# shellcheck source=/dev/null
source ./run.sh
