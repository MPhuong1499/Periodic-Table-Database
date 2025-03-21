#! /bin/bash

if [[ -z "$1" ]]; then
    echo "Please provide an element as an argument."
    exit 1
else
    echo "$1"
fi