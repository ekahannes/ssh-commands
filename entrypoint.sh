#!/bin/sh

mkdir -p ~/.ssh/
echo "$1" > ~/.ssh/private.key
chmod 600 ~/.ssh/private.key
echo "$2" > ~/.ssh/known_hosts

ls ~/.ssh/
pwd
echo "done"
ssh-keygen -y -e -f ~/.ssh/private.key
ssh-keyscan 164.90.177.64

ssh -i ~/.ssh/private.key -o UserKnownHostsFile=~/.ssh/known_hosts -tt johannes@164.90.177.64 "echo test > testfile1"
echo "known hosts file:"
cat ~/.ssh/known_hosts
# ssh -i ../private.key -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
# cat ../private.key
