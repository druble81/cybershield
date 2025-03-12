#!/bin/bash

RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)

#shuf -e ${myarray[@]}

/tmp/ramdisk/adf43513 1000 25000000 $C&
sleep 1

while :
do


echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"
echo "......................NORMAL MODE......................$D"

sudo pkill -f adf4351

C=0
echo "C is " $C

A=500
B=150


/tmp/ramdisk/adf4351 1000 25000000 $C $B&
/tmp/ramdisk/adf43512 1000 25000000 $C $B&
/tmp/ramdisk/adf43513 1000 25000000 $C $A&
/tmp/ramdisk/adf43514 1000 25000000 $C $B&
/tmp/ramdisk/adf43515 1000 25000000 $C $B&
/tmp/ramdisk/adf43516 1000 25000000 $C $B&
/tmp/ramdisk/adf43517 1000 25000000 $C $B&
/tmp/ramdisk/adf43518 1000 25000000 $C $B&
/tmp/ramdisk/adf43519 1000 25000000 $C $B&

sleep 15


done

