#!/bin/sh

# shellcheck source=/dev/null
. "$1"

if [ -z "$version" ]; then
  echo "{\"failed\": true, \"msg\": \"Arg 'version' is Required\"}"
  exit 1
fi

if (node -v); then
  echo "{}"
  exit 0
fi

if (asdf list nodejs | grep -q "$version"); then
  asdf global nodejs "$version"
  echo "{\"changed\":true}"
  exit 0
fi

asdf install nodejs "$version"
asdf global nodejs "$version"
echo "{\"changed\":true}"
