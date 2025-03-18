#!/bin/bash


cd /tmp/ramdisk

#bash /home/pi/Desktop/startall6.sh 530 0.05&
RANDOM=$$
myarray=(1 2 4 3 5 6 7 8 9)

#shuf -e ${myarray[@]}

while :
do
#shuf -e ${myarray[@]}
#RANDOM=$$
A=$(($RANDOM % 2))
#A=1
echo $A



sudo pkill -f adf4351



C=0
#C=$(($RANDOM % 4 + 1))

D=142857
B=8333

##ALWAYS ON

/tmp/ramdisk/adf43513 3000 25000000 $C $D&
##







A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
/tmp/ramdisk/adf43514 3000 25000000 $C $B&
then

/tmp/ramdisk/adf435142 3000 25000000 $C $B&
fi

A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43515 3000 25000000 $C $B&
else
/tmp/ramdisk/adf435152 3000 25000000 $C $B&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43516 3000 25000000 $C $B&
else
/tmp/ramdisk/adf435162 3000 25000000 $C $B&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43517 3000 25000000 $C $B&
else
/tmp/ramdisk/adf435172 3000 25000000 $C $B&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43518 3000 25000000 $C $B&
else
/tmp/ramdisk/adf435182 3000 25000000 $C $B&
fi



A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43519 3000 25000000 $C $B&
else
/tmp/ramdisk/adf435192 3000 25000000 $C $B&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf4351 3000 25000000 $C $B&
else
/tmp/ramdisk/adf43512s 3000 25000000 $C $B&
fi


A=$(($RANDOM % 2))
#A=1
echo $A
if [[ $A -gt 0 ]]
then
/tmp/ramdisk/adf43512 3000 25000000 $C $B&
else
/tmp/ramdisk/adf435122 3000 25000000 $C $B&
fi



echo "......................Full Coverage MODE......................"


sleep 2



done
