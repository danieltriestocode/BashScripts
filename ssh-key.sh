#!/bin/bash

# This will create a new SSH key for your Github account
# Note: This will put the keys in default location
# Pass in your email address for the arguement

key_loc="$HOME/.ssh/id_ed25519"

function _set_git_userEmail()
{
    read -p "Enter global username for Git: " name

    git config --global user.name "$name"
    git config --global user.email "$email"
}

function _create_ssh-key()
{
    email=$1

    ssh-keygen -t ed25519 -C "$email"
    eval "$(ssh-agent -s)"
    ssh-add $key_loc

    isNotInstalled=$(dpkg-query -l xclip &> /dev/null | grep "no packages found" | wc -l)

    if [ $isNotInstalled == 1 ]; then
        printf "Copy the contents below and add it to your Github account\n\n"
        cat "$key_loc.pub"
    else
        echo "Copied contents of SSH public key to clipboard"
        xclip -sel clipboard -i < "$key_loc.pub"
    fi


    read -p "Would you like to configure global username and email address? (Y|y): " answer

    if [ $answer == y ]; then _set_git_userEmail; fi
}

if [ -z $1 ]; then
    echo "Please pass in your email address"
else
    _create_ssh-key $1
fi