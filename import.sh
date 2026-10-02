#!/bin/bash
set -e

if [ "$PWD" != "$HOME" ]; then
  echo "Error: import.sh must be run in $HOME (current: $PWD)" >&2
  exit 1
fi

if [ ! -f "$HOME/.ssh/id_ed25519" ] || [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
  echo "Error: $HOME/.ssh/id_ed25519 and $HOME/.ssh/id_ed25519.pub are required" >&2
  exit 1
fi

if ! command -v git &>/dev/null; then
  echo "Installing git"
  sudo apt-get update
  sudo apt-get install git -y &>/dev/null
fi

if [ -e dotfiles ]; then
  echo "Error: $HOME/dotfiles already exists" >&2
  exit 1
fi

git clone https://github.com/logica0419/dotfiles.git

cd dotfiles || return 1
# shellcheck source=/dev/null
source ./run.sh
