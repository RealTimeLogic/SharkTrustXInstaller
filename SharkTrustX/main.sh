#!/bin/bash
set -euo pipefail

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "Usage: $0 hostname [ssh-user]" >&2
  exit 1
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
export ANSIBLE_CONFIG="$script_dir/ansible.cfg"

args=(-i "$1," "$script_dir/main.yaml")
if [ "$#" -eq 2 ]; then
  args+=(-e "ansible_user=$2")
fi

echo "Installing/upgrading SharkTrustX on $1"
ansible-playbook "${args[@]}"
