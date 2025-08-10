#!/bin/bash

RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)

#shuf -e ${myarray[@]}

/tmp/ramdisk/adf43513 1000 25000000 $C&
sudo pkill -f adf4351
while :
do


echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"
echo "......................LOW EMF MODE......................$D"



C=0
echo "C is " $C

A=7692
B=2325


/tmp/ramdisk/adf4351 1000 25000000 $C&
/tmp/ramdisk/adf43512 1000 25000000 $C&
/tmp/ramdisk/adf43513 1000 25000000 $C&
/tmp/ramdisk/adf43514 1000 25000000 $C&
/tmp/ramdisk/adf43515 1000 25000000 $C&
/tmp/ramdisk/adf43516 1000 25000000 $C&
/tmp/ramdisk/adf43517 1000 25000000 $C&
/tmp/ramdisk/adf43518 1000 25000000 $C&
/tmp/ramdisk/adf43519 1000 25000000 $C&

sleep $(($RANDOM % 2 + 1))
sudo pkill -f adf4351
sleep $(($RANDOM % 2 + 1))

done

