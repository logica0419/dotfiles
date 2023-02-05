#!/bin/bash

if [ "$ENV" != "server" ] && [ "$ENV" != "wsl" ]; then
  echo "ENV must be set to server or wsl"
  return 1
fi

sudo apt-get update >/dev/null
sudo apt-get install expect -y >/dev/null

# Install Ansible
if ! (type ansible-playbook >/dev/null 2>&1); then
  echo "Installing Ansible"
  sudo apt-get install python3-pip -y >/dev/null
  export PATH=$PATH:/home/$USER/.local/bin
  pip install ansible >/dev/null 2>&1
  sudo apt-get purge python3-pip --auto-remove -y >/dev/null
fi

while :; do
  unbuffer ansible-playbook -v -i inventory "$ENV".yaml | tee /tmp/ansible.log
  RESULT=$(
    grep -q "failed=0" </tmp/ansible.log
    echo $?
  )

  # shellcheck source=/dev/null
  source ~/.bashrc

  if (type gh >/dev/null 2>&1) && ! (gh auth status >/dev/null 2>&1); then
    gh auth login
  fi

  ssh-add -L >/dev/null 2>&1

  if [ $? -eq 1 ]; then
    ssh-add ~/.ssh/id_ed25519
  fi

  if [ "$ENV" == "wsl" ] && ! (sudo systemctl status >/dev/null 2>&1); then
    return 1
  fi

  if [ "$RESULT" == 0 ]; then
    break
  fi
done
