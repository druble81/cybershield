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




/tmp/ramdisk/adf4351 1000 25000000 $C&
/tmp/ramdisk/adf43512 1000 25000000 $C&
/tmp/ramdisk/adf43513 1000 25000000 $C&
/tmp/ramdisk/adf43514 1000 25000000 $C&
/tmp/ramdisk/adf43515 1000 25000000 $C&
/tmp/ramdisk/adf43516 1000 25000000 $C&
/tmp/ramdisk/adf43517 1000 25000000 $C&
/tmp/ramdisk/adf43518 1000 25000000 $C&
/tmp/ramdisk/adf43519 1000 25000000 $C&

sleep 120


done

