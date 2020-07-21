#!/bin/sh

echo $1 > ssh_script.sh

ssh -i ~/.ssh/id_rsa.johannes_ekaros -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
