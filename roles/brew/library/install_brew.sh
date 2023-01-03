#!/bin/sh -e

if (type brew); then
  echo "{\"changed\":false}"
  exit 0
fi

sudo apt-get install build-essential procps curl file git -y

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "{\"changed\":true}"
