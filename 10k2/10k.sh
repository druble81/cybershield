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
echo "......................FULL 10K2 MODE......................$D"
echo "......................FULL 10K2 MODE......................$D"
echo "......................FULL 10K2 MODE......................$D"
echo "......................FULL 10K2 MODE......................$D"
/tmp/ramdisk/adf43512sk2 3000 25000000 $C ${myarray[1]}&
/tmp/ramdisk/adf435132k2 3000 25000000 $C ${myarray[2]}&
/tmp/ramdisk/adf435122k2 3000 25000000 $C ${myarray[3]}&
/tmp/ramdisk/adf435142k2 3000 25000000 $C ${myarray[4]}&
/tmp/ramdisk/adf435152k2 3000 25000000 $C ${myarray[5]}&
/tmp/ramdisk/adf435162k2 3000 25000000 $C ${myarray[6]}&
/tmp/ramdisk/adf435172k2 3000 25000000 $C ${myarray[7]}&
/tmp/ramdisk/adf435182k2 3000 25000000 $C ${myarray[8]}&
/tmp/ramdisk/adf435192k2 3000 25000000 $C ${myarray[9]}&

sleep 120
sudo pkill -f adf4351

done


