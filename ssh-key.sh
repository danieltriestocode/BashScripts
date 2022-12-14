#!/bin/bash

# Description: This will create a new SSH key for your Github account
# Note:        This will put the keys in default location (Home Directory)

function _git_config()
{
    git config --global user.name "$name"
    git config --global user.email "$email"

    printf "\nHere's your git config\n"
    cat "$HOME/.gitconfig"
}

function _create_ssh-key()
{
    ssh-keygen -t ed25519 -C "$email"
    eval "$(ssh-agent -s)"

    printf "\nCopy the contents below and add it to your Github account\n"
    cat "$HOME/.ssh/id_ed25519.pub"
}

printf "\nThis script will create an ssh-key for Git into your home directory\n\n"

read -p "Please enter your name: " name
read -p "Please enter your email address: " email

_create_ssh-key
_git_config