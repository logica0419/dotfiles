#!/bin/sh -e

if (asdf plugin list | grep -q "nodejs"); then
  echo "{}"
  exit 0
fi

asdf plugin add nodejs
echo "{\"changed\":true}"
