#!/bin/bash

# This will create a new SSH key for your Github account
# Note: This will put the keys in default location
# Pass in your email address for the arguement

function _create_ssh-key()
{
    local email=$1

    # ssh-keygen -t ed25519 -C $email
    # eval "$(ssh-agent -s)"
    # ssh-add ~/.ssh/id_ed25519
    # cat ~/.ssh/id_ed25519.pub

    isNotInstalled=$(dpkg-query -l xclip &> /dev/null | grep "no packages found" | wc -l)
    
    if [ $isNotInstalled ]; then
        echo "xclip is not installed"
    else
        echo "Copied contents of SSH public key to clipboard"
    fi
}

if [ -z $1 ]; then
    echo "Please pass in your email address"
else
    _create_ssh-key $1
fi