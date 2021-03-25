#/bin/bash

if [ -z "$1" ]
  then
    echo "Usage: main.sh hostname"
    exit 1
fi

echo "Installing/upgrading sharkTrustX"
ansible-playbook -i $1, main.yaml
