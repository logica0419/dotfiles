#!/bin/bash -e

# shellcheck source=/dev/null
. "$1"

if [ -z "$name" ]; then
  echo "{\"failed\": true, \"msg\": \"Arg 'name' is Required\"}"
  exit 1
fi

if (type "$(basename "$name")"); then
  echo "{}"
  exit 0
fi

if [[ "$(basename "$name")" =~ ^v. ]] && (type "$(basename "$(dirname "$name")")"); then
  echo "{}"
  exit 0
fi

go install "$name@latest"

echo "{\"changed\":true}"
