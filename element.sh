#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z "$1" ]]; then
    echo "Please provide an element as an argument."
    exit 1
else
    if [[ "$1" =~ ^[0-9]+$ || "$1" -gt 0 || "$1" -lt 11 ]]; then 
    echo right
    exit 1
    else echo wrong
    fi
fi