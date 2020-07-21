#!/bin/sh

mkdir -p ~/.ssh/
echo $SSH_PRIVATE_KEY > ../private.key
chmod 600 ../private.key
echo "164.90.177.64 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBKtbilgQyw1CB8EefUCqjBzlwp/0+KnTHZfyaJ8xGWU/IPjwrKGyDedtwuUEm3XPqMV4e4Nwa9M3OXihGgRHWfg=" > ~/.ssh/known_hosts

echo $1 > ssh_script.sh

ssh -i ../private.key -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
