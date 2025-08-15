#!/bin/bash






while :
do

RANDOM=$$

sudo pkill -f adf4351

C=$(($RANDOM % 4 ))
C=2
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



sleep 30




done
