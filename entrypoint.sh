#!/bin/bash

mkdir -p ~/.ssh/
echo "$1" > ~/.ssh/private.key
chmod 600 ~/.ssh/private.key
echo "$2" > ~/.ssh/known_hosts

# jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"
# printenv
# jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"

STR_ARGS="export "
STR_UNSET="unset"
for s in $(jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$4"); do
    # export $s
    STR_ARGS="${STR_ARGS} $s"
    IFS='=' read -r key val <<< "$s"
    STR_UNSET="${STR_UNSET} $key"
done
echo $STR_ARGS
echo $STR_UNSET

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

echo "eval $STR_ARGS;${3}exit; eval" > ssh_script.sh
chmod +x ssh_script.sh
# ssh -i ~/.ssh/private.key -o UserKnownHostsFile=$HOME/.ssh/known_hosts -tt johannes@164.90.177.64 "eval $STR_ARGS"
ssh -i ~/.ssh/private.key -o UserKnownHostsFile=$HOME/.ssh/known_hosts -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh test

# ssh -i ../private.key  -o "StrictHostKeyChecking no" -tt johannes@164.90.177.64 'bash -s' < $(pwd)/ssh_script.sh arg1
