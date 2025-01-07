#!/bin/bash


cd /tmp/ramdisk

sudo pkill -f adf435
RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)
#shuf -e ${myarray[@]}


while :
do
RANDOM=$$
A=5
#A=1
echo $A



##if [[ $A -gt 0 ]]
##then


C=0
#C=$(($RANDOM % 4 + 1))
echo "Normal Burst"
/tmp/ramdisk/adf4351 1000 25000000 $C ${myarray[1]}&
/tmp/ramdisk/adf43512 1000 25000000 $C ${myarray[2]}&
/tmp/ramdisk/adf43513 1000 25000000 $C ${myarray[3]}&
/tmp/ramdisk/adf43514 1000 25000000 $C ${myarray[4]}&
/tmp/ramdisk/adf43515 1000 25000000 $C ${myarray[5]}&
/tmp/ramdisk/adf43516 1000 25000000 $C ${myarray[6]}&
/tmp/ramdisk/adf43517 1000 25000000 $C ${myarray[7]}&
/tmp/ramdisk/adf43518 1000 25000000 $C ${myarray[8]}&
/tmp/ramdisk/adf43519 1000 25000000 $C ${myarray[9]}&


echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"

sleep $A

sudo pkill -f adf4351


echo "10k" 
/tmp/ramdisk/adf43512s 3000 25000000 $C ${myarray[1]}&
/tmp/ramdisk/adf435132 3000 25000000 $C ${myarray[2]}&
/tmp/ramdisk/adf435122 3000 25000000 $C ${myarray[3]}&
/tmp/ramdisk/adf435142 3000 25000000 $C ${myarray[4]}&
/tmp/ramdisk/adf435152 3000 25000000 $C ${myarray[5]}&
/tmp/ramdisk/adf435162 3000 25000000 $C ${myarray[6]}&
/tmp/ramdisk/adf435172 3000 25000000 $C ${myarray[7]}&
/tmp/ramdisk/adf435182 3000 25000000 $C ${myarray[8]}&
/tmp/ramdisk/adf435192 3000 25000000 $C ${myarray[9]}&
D=$(($RANDOM % 30 + 1))
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"

sleep $A

sudo pkill -f adf4351


done
