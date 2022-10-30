#!/bin/bash

# Description: Burns an iso file onto a usb
# Requires:    The location of the usb (e.g. /dev/sdb)
#              and the name/location of the iso file 

usb="/dev/sdb"

if [ -z $1 ]; then
    echo "Please pass in the name/location of the iso file"
else
    iso_file=$1
    sudo dd bs=4M if=$iso_file of=$usb conv=fdatasync status=progress
fi

# dd:             The name of the command we’re using.
# bs=4M:          The -bs (blocksize) option defines the size of each chunk that is read
#                 from the input file and wrote to the output device. 4 MB is a good choice
#                 because it gives decent throughput and it is an exact multiple of 4 KB,
#                 which is the blocksize of the ext4 filesystem.
# if=$1:          The -if (input file) option requires the path and name of the Linux ISO
#                 image you are using as the input file.
# of=/dev/sdb:    The -of (output file) is the critical parameter.The device that
#                 represents your USB drive.
# conv=fdatasync: The conv parameter dictates how dd converts the input file as it is
#                 written to the output device. dd uses kernel disk caching when it
#                 writes to the USB drive. The fdatasync modifier ensure the write
#                 buffers are flushed correctly and completely before the creation
#                 process is flagged as having finished.