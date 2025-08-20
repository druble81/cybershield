#!/bin/bash


RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)
#shuf -e ${myarray[@]}
RANDOM=$$

FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi



while :
do
#shuf -e ${myarray[@]}






D=$(($RANDOM % 30 + 1))


#C=$(($RANDOM % 4 + 1))
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
/tmp/ramdisk/adf43512sk4 3000 25000000 $C ${myarray[1]}&
/tmp/ramdisk/adf435132k4 3000 25000000 $C ${myarray[2]}&
/tmp/ramdisk/adf435122k4 3000 25000000 $C ${myarray[3]}&
/tmp/ramdisk/adf435142k4 3000 25000000 $C ${myarray[4]}&
/tmp/ramdisk/adf435152k4 3000 25000000 $C ${myarray[5]}&
/tmp/ramdisk/adf435162k4 3000 25000000 $C ${myarray[6]}&
/tmp/ramdisk/adf435172k4 3000 25000000 $C ${myarray[7]}&
/tmp/ramdisk/adf435182k4 3000 25000000 $C ${myarray[8]}&
/tmp/ramdisk/adf435192k4 3000 25000000 $C ${myarray[9]}&

sleep 120
sudo pkill -f adf4351

done


