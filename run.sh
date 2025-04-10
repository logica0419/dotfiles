#!/bin/bash

if [ "$ENV" != "server" ] && [ "$ENV" != "wsl" ]; then
  echo "ENV must be set to server or wsl"
  return 1
fi

sudo apt-get update >/dev/null
sudo apt-get install expect -y >/dev/null

# Install Ansible
if ! (type ansible-playbook &>/dev/null); then
  sudo apt-get install python3-pip -y >/dev/null
  echo "Installing Ansible"
  export PATH=$PATH:$HOME/.local/bin
  pip install --break-system-packages ansible &>/dev/null
fi

while :; do
  unbuffer ansible-playbook -v -u "$(whoami)" -i inventory "$ENV".yaml | tee /tmp/ansible.log
  RESULT=$(
    grep -q "failed=0" </tmp/ansible.log
    echo $?
  )

  # shellcheck source=/dev/null
  source ~/.bashrc

  if [ "$ENV" == "server" ] && (type tailscale &>/dev/null) && ! (tailscale status &>/dev/null); then
    sudo tailscale up
  fi

  if [ "$ENV" == "server" ] && (type code &>/dev/null) && ! (systemctl --user status code-tunnel &>/dev/null); then
    code tunnel service install
  fi

  if [ "$ENV" == "wsl" ] && ! (sudo systemctl status &>/dev/null); then
    return 1
  fi

  if (type gh &>/dev/null) && ! (gh auth status &>/dev/null); then
    gh auth login -p https -w
  fi

  if (type docker &>/dev/null) && ! (docker ps &>/dev/null); then
    if [ "$ENV" == "wsl" ]; then
      return 1
    else
      sudo reboot
    fi
  fi

  if [ -e ~/.gitcookies ] && [ ! -s ~/.gitcookies ]; then
    return 1
  fi

  if [ "$RESULT" == 0 ]; then
    break
  fi
done

rm -rf "$HOME"/.local/bin "$HOME"/.local/lib &>/dev/null
