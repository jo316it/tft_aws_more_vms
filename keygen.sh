#!/bin/bash

echo  -e "Enter the key name: "
read KEY

if [[ "${KEY}" =~ [^A-Za-z0-9\&./=_:?-] ]]; then
    echo "That NAME is NOT allowed."
else
    mkdir -p ./modules/ec2/keys
    sleep 2
    ssh-keygen -f ./modules/ec2/keys/$KEY  -q -P ""
    echo "Ok the key was created..."
    echo "Connect from this directory using the command 'ssh -i $KEY user@ip.from.aws'"
fi
