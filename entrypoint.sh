#!/bin/bash

mkdir -p ~/.ssh/
echo "$1" > ~/.ssh/private.key
chmod 600 ~/.ssh/private.key
echo "$2" > ~/.ssh/known_hosts

echo "${3}exit" > ssh_script.sh
chmod +x ssh_script.sh

# jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"
# printenv
# jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"

STR_ARGS=""
for s in $(jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"); do
    # export $s
    # STR_ARGS="${STR_ARGS}"
    echo $s
done

# declare -A myarray
# while IFS="=" read -r key value
# do
#     myarray[$key]="$value"
# done < <(jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4")

# echo $myarray

# for key in "${!myarray[@]}"
# do
#     echo "$key = ${myarray[$key]}"
# done
# echo ${myarray[ARG]}

ssh -i ~/.ssh/private.key -o UserKnownHostsFile=$HOME/.ssh/known_hosts -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh "$(declare -p myarray)"
# ssh -i ../private.key  -o "StrictHostKeyChecking no" -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
