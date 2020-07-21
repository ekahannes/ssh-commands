#!/bin/sh

apt update && apt install openssh-client -y

mkdir -p ~/.ssh/
echo "$1" > ~/.ssh/private.key
chmod 600 ~/.ssh/private.key
echo "$2" > ~/.ssh/known_hosts

echo "ssh-keygen"
ssh-keygen -y -e -f ~/.ssh/private.key
echo "ssh-keyscan"
ssh-keyscan 164.90.177.64

ssh -i ~/.ssh/private.key -tt johannes@164.90.177.64 "echo test > testfile1"
echo "known hosts"
cat ~/.ssh/known_hosts
# ssh -i ../private.key -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
# cat ../private.key
