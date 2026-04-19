#!/bin/bash
set -eu

# shellcheck source=/dev/null
. "$1"

if [ -z "$name" ]; then
  echo "{\"failed\": true, \"msg\": \"Arg \\\"name\\\" is Required\"}"
  exit 1
fi

if command -v "$(basename "$name")" &>/dev/null; then
  echo "{}"
  exit 0
fi

if [[ "$(basename "$name")" =~ ^v. ]] && command -v "$(basename "$(dirname "$name")")" &>/dev/null; then
  echo "{}"
  exit 0
fi

go install "$name@latest"

echo "{\"changed\":true}"
