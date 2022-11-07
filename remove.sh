#!/bin/bash

# Description: Removes spaces in filenames in current directory
#              Replaces/Removes a specific pattern
# Note:        If user wants to remove a pattern only then enter 0
#              for the second arguement

for file in *; do
    mv "$file" > /dev/null 2>&1 `echo $file | tr ' ' '_'`
done

if ! [[ -z $2 ]]; then
    if [ $2 == 0 ]; then
        for f in *$1*; do
            mv -- "$f" "${f/$1/}"
        done
    else
        for f in *$1*; do
            mv -- "$f" "${f/$1/$2}"
        done
    fi
fi