#!/bin/bash


cd /tmp/ramdisk

RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)

#shuf -e ${myarray[@]}

while :
do
#RANDOM=$$
A=$(($RANDOM % 2))
#A=1
echo $A
#shuf -e ${myarray[@]}

sudo pkill -f adf4351


C=3
#C=$(($RANDOM % 4 + 1))
echo "Normal Burst"


##ALWAYS ON

/tmp/ramdisk/adf43513 3000 25000000 $C ${myarray[3]}&
##




A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf4351 3000 25000000 $C ${myarray[1]}&
else
/tmp/ramdisk/adf43512s 3000 25000000 $C${myarray[1]}&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43512 3000 25000000 $C ${myarray[2]}&
else
/tmp/ramdisk/adf435122 3000 25000000 $C ${myarray[2]}&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43514 3000 25000000 $C ${myarray[3]}&
/tmp/ramdisk/adf435142 3000 25000000 $C ${myarray[3]}&
fi

A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43515 3000 25000000 $C ${myarray[4]}&
else
/tmp/ramdisk/adf435152 3000 25000000 $C ${myarray[4]}&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43516 3000 25000000 $C ${myarray[5]}&
else
/tmp/ramdisk/adf435162 3000 25000000 $C ${myarray[5]}&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43517 3000 25000000 $C ${myarray[6]}&
else
/tmp/ramdisk/adf435172 3000 25000000 $C ${myarray[6]}&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43518 3000 25000000 $C ${myarray[7]}&
else
/tmp/ramdisk/adf435182 3000 25000000 $C ${myarray[7]}&
fi

A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43519 3000 25000000 $C ${myarray[8]}&
else
/tmp/ramdisk/adf435192 3000 25000000 $C ${myarray[8]}&
fi

echo "......................1SSSSSSSSSSSSSS0K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"
echo "......................10K BURST MODE......................"

sleep 10
#sleep 6




done
