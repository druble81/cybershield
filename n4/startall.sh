#!/bin/bash


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



while :
do

A=1
#A=1
echo $A






B=25000
A=8264



echo "n2" 
/tmp/ramdisk/adf43512sn4 3000 25000000 $C $B&
/tmp/ramdisk/adf435132n4 3000 25000000 $C $A&
/tmp/ramdisk/adf435122n4 3000 25000000 $C $B&
/tmp/ramdisk/adf435142n4 3000 25000000 $C $B&
/tmp/ramdisk/adf435152n4 3000 25000000 $C $B&
/tmp/ramdisk/adf435162n4 3000 25000000 $C $B&
/tmp/ramdisk/adf435172n4 3000 25000000 $C $B&
/tmp/ramdisk/adf435182n4 3000 25000000 $C $B&
/tmp/ramdisk/adf435192n4 3000 25000000 $C $B&
D=$(($RANDOM % 30 + 1))
echo "......................N4 MODE......................$D"
echo "......................N4 MODE......................$D"
echo "......................N4 MODE......................$D"
echo "......................N4 MODE......................$D"
echo "......................N4 MODE......................$D"
echo "......................N4 MODE......................$D"

sleep 30

sudo pkill -f adf4351

done
