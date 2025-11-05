#!/bin/bash

# Path to the file
FILE="/home/pi/Desktop/nvalues.txt"

# Default values
DEFAULT_T1=140
DEFAULT_T2=65

# Check if file exists and load values, otherwise use defaults
if [[ -f "$FILE" ]]; then
    # Read first two values from the file
    read T1 T2 < "$FILE"
else
    T1=$DEFAULT_T1
    T2=$DEFAULT_T2
fi


T3=$((T1*5))
T4=$((T2*4))


FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi

/home/pi/Desktop/startall3/adf4351 200 25000000 $C $T1 $T2&
/home/pi/Desktop/startall3/adf43512 200 25000000 $C $T1 $T2&
/home/pi/Desktop/startall3/adf43513 200 25000000 $C $T3 $T4&
/home/pi/Desktop/startall3/adf43514 200 25000000 $C $T1 $T2&
/home/pi/Desktop/startall3/adf43515 200 25000000 $C $T1 $T2&
/home/pi/Desktop/startall3/adf43516 200 25000000 $C $T1 $T2&
/home/pi/Desktop/startall3/adf43517 200 25000000 $C $T1 $T2&
/home/pi/Desktop/startall3/adf43518 200 25000000 $C $T1 $T2&
/home/pi/Desktop/startall3/adf43519 200 25000000 $C $T1 $T2&

while :
do


#sudo pkill -f adf4351

echo "PFC"


sleep 10




done
