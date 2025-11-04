#!/bin/bash

FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi

echo C is $C


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


T3=$((T1*2))
T4=$((T2*3))

RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)
RANDOM=$$
while :
do





D=$(($RANDOM % 30 + 1))



echo "......................RESISTANCE MODE......................$D"
echo "......................RESISTANCE MODE......................$D"
echo "......................RESISTANCE MODE......................$D"
echo "......................RESISTANCE MODE......................$D"
/home/pi/Desktop/1020/adf4351 3000 25000000  $C $T1 $T2&
/home/pi/Desktop/1020/adf43513 3000 25000000 $C $T3 $T4&
/home/pi/Desktop/1020/adf43512 3000 25000000 $C $T1 $T2&
/home/pi/Desktop/1020/adf43514 3000 25000000 $C $T1 $T2&
/home/pi/Desktop/1020/adf43515 3000 25000000 $C $T1 $T2&
/home/pi/Desktop/1020/adf43516 3000 25000000 $C $T1 $T2&
/home/pi/Desktop/1020/adf43517 3000 25000000 $C $T1 $T2&
/home/pi/Desktop/1020/adf43518 3000 25000000 $C $T1 $T2&
/home/pi/Desktop/1020/adf43519 3000 25000000 $C $T1 $T2&

sleep 30
sudo pkill -f adf4351


done


