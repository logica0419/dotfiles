#!/bin/bash

if command -v brew &>/dev/null; then
  echo "{}"
  exit 0
fi

case "$(uname -s)" in
  Linux)
    sudo apt-get install build-essential procps curl file git -y
    ;;
esac

NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "{\"changed\":true}"
