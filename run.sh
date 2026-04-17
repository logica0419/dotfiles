#!/bin/bash

if [ "$ENV" != "server" ] && [ "$ENV" != "wsl" ] && [ "$ENV" != "mac" ]; then
  echo "ENV must be set to server, wsl or mac"
  return 1
fi

if ! (type uv &>/dev/null); then
  echo "Installing uv"
  curl -LsSf https://astral.sh/uv/install.sh | sh >/dev/null 2>&1
  export PATH=$PATH:$HOME/.local/bin
fi
uv sync >/dev/null

if [ "$ENV" != "mac" ] && ! (type unbuffer &>/dev/null); then
  sudo apt-get update &>/dev/null
  sudo apt-get install expect -y &>/dev/null
fi

while :; do
  if [ "$ENV" == "mac" ]; then
    script -q /tmp/ansible.log uv run ansible-playbook -v -u "$(whoami)" -i inventory "$ENV".yaml
  else
    unbuffer uv run ansible-playbook -v -u "$(whoami)" -i inventory "$ENV".yaml | tee /tmp/ansible.log
  fi
  RESULT=$(
    grep -q "failed=0" </tmp/ansible.log
    echo $?
  )

  # shellcheck source=/dev/null
  source ~/.profile
  # shellcheck source=/dev/null
  source ~/.bashrc

  if [ "$ENV" == "server" ] && (type tailscale &>/dev/null) && ! (tailscale status &>/dev/null); then
    sudo tailscale up
  fi

  if [ "$ENV" == "server" ] && (type code &>/dev/null) && ! (systemctl --user status code-tunnel &>/dev/null); then
    code tunnel service install
    systemctl --user daemon-reload &>/dev/null
    systemctl --user restart code-tunnel &>/dev/null
  fi

  if [ "$ENV" == "wsl" ] && ! (sudo systemctl status &>/dev/null); then
    return 1
  fi

  if (type gh &>/dev/null) && ! (gh auth status &>/dev/null); then
    gh auth login -p https -w
  fi

  if (type docker &>/dev/null) && ! (docker ps &>/dev/null); then
    if [ "$ENV" == "server" ]; then
      sudo reboot 0
    fi
    return 1
  fi

  if [ -e ~/.gitcookies ] && [ ! -s ~/.gitcookies ]; then
    return 1
  fi

  if [ "$RESULT" == 0 ]; then
    break
  fi
done

rm "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx" &>/dev/null
