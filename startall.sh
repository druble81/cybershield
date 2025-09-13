#!/bin/bash

RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)

#shuf -e ${myarray[@]}

/tmp/ramdisk/adf43513 1000 25000000 $C&
sudo pkill -f adf4351

FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi








/tmp/ramdisk/adf4351 1000 25000000 $C&
/tmp/ramdisk/adf43512 1000 25000000 $C&
/tmp/ramdisk/adf43513 1000 25000000 $C&
/tmp/ramdisk/adf43514 1000 25000000 $C&
/tmp/ramdisk/adf43515 1000 25000000 $C&
/tmp/ramdisk/adf43516 1000 25000000 $C&
/tmp/ramdisk/adf43517 1000 25000000 $C&
/tmp/ramdisk/adf43518 1000 25000000 $C&
/tmp/ramdisk/adf43519 1000 25000000 $C&



while :
do

#sleep $(($RANDOM % 10 + 5))
#sudo pkill -f adf4351

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




echo "C is " $C
sleep $(($RANDOM % 3 + 1))
done

