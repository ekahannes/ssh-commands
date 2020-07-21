#!/bin/sh

mkdir -p ~/.ssh/
echo "$1" > ~/.ssh/private.key
chmod 600 ~/.ssh/private.key
echo "164.90.177.64 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBKtbilgQyw1CB8EefUCqjBzlwp/0+KnTHZfyaJ8xGWU/IPjwrKGyDedtwuUEm3XPqMV4e4Nwa9M3OXihGgRHWfg=" > ~/.ssh/known_hosts

ls ~/.ssh/
pwd
echo "done"
ssh-keygen -y -e -f ~/.ssh/private.key
ssh-keyscan 164.90.177.64

ssh -i ~/.ssh/private.key -tt johannes@164.90.177.64 "echo test > testfile1"
echo "known hosts"
cat ~/.ssh/known_hosts
# ssh -i ../private.key -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
# cat ../private.key
