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



##if [[ $A -gt 0 ]]
##then




echo "Normal Burst" 
A=1600
B=800


/tmp/ramdisk/adf4351 1000 25000000 $C&
/tmp/ramdisk/adf43512 1000 25000000 $C&
/tmp/ramdisk/adf43513 1000 25000000 $C&
/tmp/ramdisk/adf43514 1000 25000000 $C&
/tmp/ramdisk/adf43515 1000 25000000 $C&
/tmp/ramdisk/adf43516 1000 25000000 $C&
/tmp/ramdisk/adf43517 1000 25000000 $C&
/tmp/ramdisk/adf43518 1000 25000000 $C&
/tmp/ramdisk/adf43519 1000 25000000 $C&


echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"

sleep $(($RANDOM % 3 + 1))

sudo pkill -f adf4351


B=25000
A=8264

echo "10k" 
/tmp/ramdisk/adf43512s 3000 25000000 $C&
/tmp/ramdisk/adf435132 3000 25000000 $C&
/tmp/ramdisk/adf435122 3000 25000000 $C&
/tmp/ramdisk/adf435142 3000 25000000 $C&
/tmp/ramdisk/adf435152 3000 25000000 $C&
/tmp/ramdisk/adf435162 3000 25000000 $C&
/tmp/ramdisk/adf435172 3000 25000000 $C&
/tmp/ramdisk/adf435182 3000 25000000 $C&
/tmp/ramdisk/adf435192 3000 25000000 $C&
D=$(($RANDOM % 30 + 1))
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"

sleep $(($RANDOM % 3 + 1))

sudo pkill -f adf4351









done
