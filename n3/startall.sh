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



C=3



B=25000
A=8264



echo "n2" 
/tmp/ramdisk/adf43512sn3 3000 25000000 $C $B&
/tmp/ramdisk/adf435132n3 3000 25000000 $C $A&
/tmp/ramdisk/adf435122n3 3000 25000000 $C $B&
/tmp/ramdisk/adf435142n3 3000 25000000 $C $B&
/tmp/ramdisk/adf435152n3 3000 25000000 $C $B&
/tmp/ramdisk/adf435162n3 3000 25000000 $C $B&
/tmp/ramdisk/adf435172n3 3000 25000000 $C $B&
/tmp/ramdisk/adf435182n3 3000 25000000 $C $B&
/tmp/ramdisk/adf435192n3 3000 25000000 $C $B&
D=$(($RANDOM % 30 + 1))
echo "......................N3 MODE......................$D"
echo "......................N3 MODE......................$D"
echo "......................N3 MODE......................$D"
echo "......................N3 MODE......................$D"
echo "......................N3 MODE......................$D"
echo "......................N3 MODE......................$D"

sleep 30

sudo pkill -f adf4351

done
