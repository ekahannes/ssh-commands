#!/bin/bash

# setup files required for ssh
mkdir -p ~/.ssh/
echo "$1" > ~/.ssh/private.key
chmod 600 ~/.ssh/private.key
echo "$2" > ~/.ssh/known_hosts

# setup export of variables to remote environment
STR_ARGS="export"
STR_UNSET="unset"
$STRING=$(jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4")
# for s in $(jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"); do
#     export $s
#     STR_ARGS="${STR_ARGS} $s"
#     IFS='=' read -r key val <<< "$s"
#     STR_UNSET="${STR_UNSET} $key"
# done
while IFS= read -r line; do
    echo "... $line ..."
done <<< "$STRING"

# write commands script to local file
echo "eval $STR_ARGS;${3}exit; eval $STR_UNSET" > ssh_script.sh
chmod +x ssh_script.sh

# execute commands script on remote via ssh
ssh -i ~/.ssh/private.key -o UserKnownHostsFile=$HOME/.ssh/known_hosts -tt ${SSH_USERNAME}@${SERVER_IP} 'bash -s' < $(pwd)/ssh_script.sh
