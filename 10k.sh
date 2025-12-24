#!/bin/bash


RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)
#shuf -e ${myarray[@]}
FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi


RANDOM=$$

#shuf -e ${myarray[@]}



# Path to the file
FILE="/home/pi/Desktop/10values.txt"

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

D=$(($RANDOM % 30 + 1))

#C=$(($RANDOM % 4 + 1))

while :
do

sudo pkill -f "adf4351[0-9]*"

/tmp/ramdisk/adf43512s 3000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf435132 3000 25000000 $C $T3 $T4&
/tmp/ramdisk/adf435122 3000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf435142 3000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf435152 3000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf435162 3000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf435172 3000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf435182 3000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf435192 3000 25000000 $C $T1 $T2&





echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"

sleep $(($RANDOM % 30 + 30))


done


