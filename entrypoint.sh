#!/bin/bash

# setup files required for ssh
mkdir -p /github/workspace/.ssh/
echo "$1" > /github/workspace/.ssh/private.key
chmod 600 /github/workspace/.ssh/private.key
echo "$2" > /github/workspace/.ssh/known_hosts

# setup export of variables to remote environment
STR_ARGS="export"
STR_UNSET="unset"
for s in $(jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"); do
    # export $s
    STR_ARGS="${STR_ARGS} $s"
    IFS='=' read -r key val <<< "$s"
    STR_UNSET="${STR_UNSET} $key"
done

# write commands script to local file
echo "eval $STR_ARGS;${3}exit; eval $STR_UNSET" > ssh_script.sh
chmod +x ssh_script.sh
ls /github/workspace/.ssh/
# execute commands script on remote via ssh
ssh -i ~/.ssh/private.key -o UserKnownHostsFile=/github/workspace/.ssh/known_hosts -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh
