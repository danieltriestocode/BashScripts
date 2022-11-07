#!/bin/bash

# Removes a keyword in a file name

# for file in *; do mv "$file" `echo $file | tr ' ' '_'` ; done

if [ -z $1 ] && [ -z $2 ]; then
    echo "Please enter \"$0 <pattern> <new_pattern>\""
else
    for f in *$1*; do
        mv -- "$f" "${f/$1/$2}"
    done
fi