#!/bin/bash



RANDOM=$$
myarray=(1 2 3 4 5 6 7 8 9)
RANDOM=$$
while :
do





D=$(($RANDOM % 30 + 1))

C=0
#C=$(($RANDOM % 4 + 1))
echo "......................RESISTANCE MODE......................$D"
echo "......................RESISTANCE MODE......................$D"
echo "......................RESISTANCE MODE......................$D"
echo "......................RESISTANCE MODE......................$D"
/home/pi/Desktop/1020/adf4351 3000 25000000 $C& 2>/dev/null
/home/pi/Desktop/1020/adf43513 3000 25000000 $C&  2>/dev/null
/home/pi/Desktop/1020/adf43512 3000 25000000 $C& 2>/dev/null
/home/pi/Desktop/1020/adf43514 3000 25000000 $C& 2>/dev/null
/home/pi/Desktop/1020/adf43515 3000 25000000 $C& 2>/dev/null
/home/pi/Desktop/1020/adf43516 3000 25000000 $C& 2>/dev/null
/home/pi/Desktop/1020/adf43517 3000 25000000 $C& 2>/dev/null
/home/pi/Desktop/1020/adf43518 3000 25000000 $C& 2>/dev/null
/home/pi/Desktop/1020/adf43519 3000 25000000 $C& 2>/dev/null

sleep 20
sudo pkill -f adf4351


done


