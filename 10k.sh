#!/bin/bash


RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)
#shuf -e ${myarray[@]}
RANDOM=$$
while :
do
#shuf -e ${myarray[@]}






D=$(($RANDOM % 30 + 1))

C=3
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

sleep 10
sudo pkill -f adf4351

done


