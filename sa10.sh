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

sleep 3

sudo pkill -f adf4351


B=25000
A=8264

echo "PFC" 
/home/pi/Desktop/startall3/adf4351 200 25000000 $C&
/home/pi/Desktop/startall3/adf43512 200 25000000 $C&
/home/pi/Desktop/startall3/adf43513 200 25000000 $C&
/home/pi/Desktop/startall3/adf43514 200 25000000 $C&
/home/pi/Desktop/startall3/adf43515 200 25000000 $C&
/home/pi/Desktop/startall3/adf43516 200 25000000 $C&
/home/pi/Desktop/startall3/adf43517 200 25000000 $C&
/home/pi/Desktop/startall3/adf43518 200 25000000 $C&
/home/pi/Desktop/startall3/adf43519 200 25000000 $C&
D=$(($RANDOM % 30 + 1))
echo "......................PFC BURST MODE......................$D"
echo "......................PFC BURST MODE......................$D"
echo "......................PFC BURST MODE......................$D"
echo "......................PFC BURST MODE......................$D"
echo "......................PFC BURST MODE......................$D"
echo "......................PFC BURST MODE......................$D"

sleep 3

sudo pkill -f adf4351

done
