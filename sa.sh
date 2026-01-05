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


T3=$((T1*2))
T4=$((T2*2))

# Path to the file
FILE="/home/pi/Desktop/10values.txt"

# Default values
DEFAULT_T3=140
DEFAULT_T4=65

# Check if file exists and load values, otherwise use defaults
if [[ -f "$FILE" ]]; then
    # Read first two values from the file
    read T5 T6 < "$FILE"
else
    T5=$DEFAULT_T3
    T6=$DEFAULT_T4
fi

T7=$((T5*2))
T8=$((T6*2))

cd /tmp/ramdisk

sudo pkill -f adf435
SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED
myarray=(1 2 3 4 5 6 7 8 9)
#shuf -e ${myarray[@]}

#sudo /home/pi/Desktop/loadrdDEW.sh
FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi




while true; do


A=1
#A=1
echo $A


##if [[ $A -gt 0 ]]
##then



echo "Normal Burst" 


/tmp/ramdisk/adf4351 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43512 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43513 1000 25000000 $C $T3 $T4&
/tmp/ramdisk/adf43514 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43515 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43516 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43517 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43518 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43519 1000 25000000 $C $T1 $T2&


echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"

#sleep 1.$(($RANDOM % 3))
sleep 10
sudo pkill -f adf4351


echo "10k" 
/tmp/ramdisk/adf43512s 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435132 3000 25000000 $C $T7 $T8&
/tmp/ramdisk/adf435122 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435142 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435152 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435162 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435172 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435182 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435192 3000 25000000 $C $T5 $T6&
D=$(($RANDOM % 30 + 1))
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"

#sleep 1.$(($RANDOM % 3))
sleep 10

sudo pkill -f adf4351


done
