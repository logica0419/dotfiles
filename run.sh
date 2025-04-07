#!/bin/bash

if [ "$ENV" != "server" ] && [ "$ENV" != "wsl" ]; then
  echo "ENV must be set to server or wsl"
  return 1
fi

sudo apt-get update >/dev/null
sudo apt-get install expect -y >/dev/null

# Install Ansible
if ! (type ansible-playbook >/dev/null 2>&1); then
  sudo apt-get install python3-pip -y >/dev/null
  echo "Installing Ansible"
  export PATH=$PATH:$HOME/.local/bin
  pip install --break-system-packages ansible >/dev/null 2>&1
fi

while :; do
  unbuffer ansible-playbook -v -u "$(whoami)" -i inventory "$ENV".yaml | tee /tmp/ansible.log
  RESULT=$(
    grep -q "failed=0" </tmp/ansible.log
    echo $?
  )

  # shellcheck source=/dev/null
  source ~/.bashrc

  if [ "$ENV" == "server" ] && (type tailscale >/dev/null 2>&1); then
    sudo tailscale up
  fi

  if [ "$ENV" == "server" ] && (type code >/dev/null 2>&1); then
    code tunnel service install
  fi

  if [ "$ENV" == "wsl" ] && ! (sudo systemctl status >/dev/null 2>&1); then
    return 1
  fi

  if (type gh >/dev/null 2>&1) && ! (gh auth status >/dev/null 2>&1); then
    gh auth login -p https -w
    continue
  fi

  if (type docker >/dev/null 2>&1) && ! (docker ps >/dev/null 2>&1); then
    return 1
  fi

  if [ ! -e ~/.gitcookies ]; then
    return 1
  fi

  if [ "$RESULT" == 0 ]; then
    break
  fi
done

rm -rf "$HOME"/.local/bin "$HOME"/.local/lib >/dev/null 2>&1
