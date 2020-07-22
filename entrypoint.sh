#!/bin/sh

mkdir -p ~/.ssh/
echo "$1" > ~/.ssh/private.key
chmod 600 ~/.ssh/private.key
echo "$2" > ~/.ssh/known_hosts

echo "${3}exit" > ssh_script.sh
chmod +x ssh_script.sh

# jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"
# printenv
jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"

ssh -i ~/.ssh/private.key -o UserKnownHostsFile=$HOME/.ssh/known_hosts -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh
# ssh -i ../private.key  -o "StrictHostKeyChecking no" -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
