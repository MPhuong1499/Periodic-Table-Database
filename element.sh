#!/bin/bash

# Check if an argument is provided
if [[ -z "$1" ]]; then
    echo "Please provide an element as an argument."
    exit 0
fi

# Store the input argument
INPUT=$1

# Set up psql command
PSQL="psql -U freecodecamp -d periodic_table --tuples-only -c"

# Check if the input is a number (atomic_number)
if [[ "$INPUT" =~ ^[0-9]+$ ]]; then
    # Query by atomic_number
    RESULT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number JOIN types t ON p.type_id = t.type_id WHERE e.atomic_number = $INPUT;")
    read RESULT NAME SYMBOL TYPE MASS MELTING BOILING <<< $(echo "$RESULT" | tr '|' ' ' | xargs)
else
    # Query by symbol or name
    RESULT=$($PSQL "SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number JOIN types t ON p.type_id = t.type_id WHERE symbol = '$INPUT' OR name = '$INPUT';")
    read RESULT NAME SYMBOL TYPE MASS MELTING BOILING <<< $(echo "$RESULT" | tr '|' ' ' | xargs)
fi

# Check if the result is empty
if [[ -z "$RESULT" ]]; then
    echo "I could not find that element in the database."
    exit 0
fi

# Output the atomic_number
echo "The element with atomic number $RESULT is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."