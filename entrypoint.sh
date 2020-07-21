#!/bin/sh

mkdir -p ~/.ssh/
echo "$1" > ../private.key
chmod 600 ../private.key
echo "$2" > ~/.ssh/known_hosts

echo "$3" > ssh_script.sh

ssh -i ../private.key -tt johannes@164.90.177.64 "echo test > testfile1"
# ssh -i ../private.key -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
# cat ../private.key
