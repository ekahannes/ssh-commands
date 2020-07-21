#!/bin/sh

mkdir -p ~/.ssh/
echo $SSH_PRIVATE_KEY > ../private.key
chmod 600 ../private.key
echo $SSH_KNOWN_HOSTS > ~/.ssh/known_hosts
cat ~/.ssh/known_hosts

echo $1 > ssh_script.sh

ssh -i ../private.key -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
