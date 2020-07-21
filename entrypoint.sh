#!/bin/sh

mkdir -p ~/.ssh/
echo ${secrets.SSH_PRIVATE_KEY} > ../private.key
sudo chmod 600 ../private.key
echo ${secrets.SSH_KNOWN_HOSTS_DEV} > ~/.ssh/known_hosts

echo $1 > ssh_script.sh

ssh -i ~/.ssh/id_rsa.johannes_ekaros -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
