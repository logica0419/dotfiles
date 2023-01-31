#!/bin/sh

if [ "$ENV" != "local" ] && [ "$ENV" != "remote" ] && [ "$ENV" != "wsl" ]; then
  echo "ENV must be set to local, remote or wsl"
  return 1
fi

# cd || return 1

# Install Ansible
if ! (type ansible-playbook >/dev/null 2>&1); then
  echo "Installing Ansible"
  sudo apt-get install ansible -y >/dev/null
  (
    sleep 0.1
    sudo apt-get remove ansible -y >/dev/null
    sudo apt autoremove -y >/dev/null
  ) &
fi

ansible-playbook -v -i inventory "$ENV".yaml
