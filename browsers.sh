#!/bin/bash

# This will either extract or insert your default profile
# from either Firefox or Brave with your USB
# use ". ./<script_name>" to run script

function _insertion
{
    # remove the default profile
    rm -rf $path/$profile

    # create the profile again
    mkdir  $path/$profile

    # copy the contents from USB to local profile
    cp -r $usb_path/$brave_prof/* $path/$profile
}

function _extraction
{
    # check if custom profile exists in USB
    prof_exist=$(ls $usb_path | grep $brow_prof | wc -l)
    if [ $prof_exist != 0 ]; then rm -rf $usb_path/$brow_prof; fi

    # create a new custom prof in USB
    mkdir $usb_path/$brow_prof

    # copy the contents from local profile to USB
    cp -r $path/$profile/* $usb_path/$brow_prof
}

function _selection
{
    read -p "Do you want to extract or insert? [e/i]: " choice

    if   [ "$choice" == 'e' ]; then
        _extraction
    elif [ "$choice" == 'i' ]; then
        _insertion
    else
        _selection
    fi
}

function _choose
{
    read -p "Firefox or Brave? [f/b]: " choice

    if   [ "$choice" == 'f' ]; then
        path="$HOME/.mozilla/firefox"
        profile=$(ls $path | grep "default-release")
        brow_prof="firefox_profile"
    elif [ "$choice" == 'b' ]; then
        path="$HOME/.config/BraveSoftware/Brave-Browser"
        profile=$(ls $path | grep "Default")
        brow_prof="brave_profile"
    else
        _choose
    fi
}


isUsbInserted=$(lsblk -o MOUNTPOINT | grep media | wc -l)

if [ $isUsbInserted == 0 ]; then
    echo "Usb is NOT inserted"
else
    usb_path=$(lsblk -o MOUNTPOINT | grep media)
    _choose     # user chooses what browser they want
    _selection  # user selects whether they want to extract/insert
fi