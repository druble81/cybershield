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
while :
do
#shuf -e ${myarray[@]}






D=$(($RANDOM % 30 + 1))

#C=$(($RANDOM % 4 + 1))
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
/tmp/ramdisk/adf43512s 3000 25000000 $C&
/tmp/ramdisk/adf435132 3000 25000000 $C&
/tmp/ramdisk/adf435122 3000 25000000 $C&
/tmp/ramdisk/adf435142 3000 25000000 $C&
/tmp/ramdisk/adf435152 3000 25000000 $C&
/tmp/ramdisk/adf435162 3000 25000000 $C&
/tmp/ramdisk/adf435172 3000 25000000 $C&
/tmp/ramdisk/adf435182 3000 25000000 $C&
/tmp/ramdisk/adf435192 3000 25000000 $C&

sleep $(($RANDOM % 15 + 5))
sudo pkill -f adf4351

done


