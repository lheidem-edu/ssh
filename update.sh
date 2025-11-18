#!/usr/bin/env bash

if ! command -v jq &> /dev/null
then
    exit 1
fi

mkdir -p machines
jq -c '.machines[]' config.json | while read -r machine; do
    machine_name=$(echo "$machine" | jq -r '.name')
    mkdir -p "machines/$machine_name"

    authorized_keys_file="machines/$machine_name/authorized_keys"

    if [ -f "$authorized_keys_file" ]; then
        rm "$authorized_keys_file"
    fi

    echo "$machine" | jq -r '.users[]' | while read -r user; do
        public_key_file="users/$user.txt"

        if [ ! -f "$public_key_file" ]; then
            continue
        fi

        public_key=$(cat "$public_key_file" | tr -d '\n')
        echo "$public_key" >> "$authorized_keys_file"
    done
done
