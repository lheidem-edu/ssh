#!/usr/bin/env bash

if ! command -v curl &> /dev/null
then
    exit 1
fi

if [ ! -d ~/.ssh ]; then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
fi

machine_name=$(hostname -f)
authorized_keys_file_url="https://github.com/lheidem-edu/ssh/raw/refs/heads/master/machines/$machine_name/authorized_keys"

temp_file=$(mktemp)

curl -fsSL "$authorized_keys_file_url" -o "$temp_file"
if [ $? -ne 0 ]; then
    exit 1
fi

mv "$temp_file" ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
