#!/bin/bash

cd /home/pi/Desktop

RANDOM=$$

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
T4=$((T2*2))

/tmp/ramdisk/adf43513 1000 25000000 0 $T1 $T2&
sudo pkill -f "adf4351[0-9]*"

FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi

/tmp/ramdisk/adf4351 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43512 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43513 1000 25000000 $C $T3 $T4&
/tmp/ramdisk/adf43514 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43515 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43516 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43517 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43518 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43519 1000 25000000 $C $T1 $T2&

echo "C is " $C
sleep $(($RANDOM % 5 + 5))
sudo pkill -f "adf4351[0-9]*"

/tmp/ramdisk/adf4351 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43512 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43513 1000 25000000 $C $T3 $T4&
/tmp/ramdisk/adf43514 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43515 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43516 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43517 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43518 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43519 1000 25000000 $C $T1 $T2&

# Initialize loop counter
ITER=0

while :
do
    ITER=$((ITER + 1))
    sleep $(($RANDOM % 10 + 5))

    # Every 20 iterations, trigger the loadrd command with a random parameter (15-50)
    if (( ITER % 2 == 0 )); then
        RAND_PARAM=$(( (RANDOM % 36) + 15 ))
        echo ">>> [ITERATION $ITER] Triggering loadrd command with random parameter: $RAND_PARAM"
        sudo /home/pi/Desktop/loadrd 35 4400 "$RAND_PARAM"
    fi

    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"
    echo "......................NORMAL MODE......................$D"

done
