#/bin/bash

if [ -z "$1" ]
  then
    echo "Usage: main.sh ip-address"
    exit 1
fi

echo "First time Ansible preparation for $1"
ansible-playbook -u root --ask-pass -i $1, main.yaml
