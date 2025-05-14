#!/bin/bash


cd /tmp/ramdisk

sudo pkill -f adf435
SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED
myarray=(1 2 3 4 5 6 7 8 9)
#shuf -e ${myarray[@]}

#sudo /home/pi/Desktop/loadrdDEW.sh


while :
do

A=1
#A=1
echo $A



##if [[ $A -gt 0 ]]
##then


C=1

echo "Normal Burst" 
A=1600
B=800


/tmp/ramdisk/adf4351 1000 25000000 $C $B&
/tmp/ramdisk/adf43512 1000 25000000 $C $B&
/tmp/ramdisk/adf43513 1000 25000000 $C $A&
/tmp/ramdisk/adf43514 1000 25000000 $C $B&
/tmp/ramdisk/adf43515 1000 25000000 $C $B&
/tmp/ramdisk/adf43516 1000 25000000 $C $B&
/tmp/ramdisk/adf43517 1000 25000000 $C $B&
/tmp/ramdisk/adf43518 1000 25000000 $C $B&
/tmp/ramdisk/adf43519 1000 25000000 $C $B&


echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"

sleep 1

sudo pkill -f adf4351

B=25000
A=8264

echo "10k" 
/tmp/ramdisk/adf43512s 3000 25000000 $C $B&
/tmp/ramdisk/adf435132 3000 25000000 $C $A&
/tmp/ramdisk/adf435122 3000 25000000 $C $B&
/tmp/ramdisk/adf435142 3000 25000000 $C $B&
/tmp/ramdisk/adf435152 3000 25000000 $C $B&
/tmp/ramdisk/adf435162 3000 25000000 $C $B&
/tmp/ramdisk/adf435172 3000 25000000 $C $B&
/tmp/ramdisk/adf435182 3000 25000000 $C $B&
/tmp/ramdisk/adf435192 3000 25000000 $C $B&
D=$(($RANDOM % 30 + 1))
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"

sleep 0.9

sudo pkill -f adf4351


done
