#!/bin/bash


RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)
#shuf -e ${myarray[@]}
RANDOM=$$
while :
do
#shuf -e ${myarray[@]}






D=$(($RANDOM % 30 + 1))

C=0
#C=$(($RANDOM % 4 + 1))
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
echo "......................FULL 10K MODE......................$D"
/tmp/ramdisk/adf43512s 3000 25000000 $C ${myarray[1]}&
/tmp/ramdisk/adf435132 3000 25000000 $C ${myarray[2]}&
/tmp/ramdisk/adf435122 3000 25000000 $C ${myarray[3]}&
/tmp/ramdisk/adf435142 3000 25000000 $C ${myarray[4]}&
/tmp/ramdisk/adf435152 3000 25000000 $C ${myarray[5]}&
/tmp/ramdisk/adf435162 3000 25000000 $C ${myarray[6]}&
/tmp/ramdisk/adf435172 3000 25000000 $C ${myarray[7]}&
/tmp/ramdisk/adf435182 3000 25000000 $C ${myarray[8]}&
/tmp/ramdisk/adf435192 3000 25000000 $C ${myarray[9]}&

sleep 120
sudo pkill -f adf4351

done


