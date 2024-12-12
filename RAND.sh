#!/bin/bash


cd /tmp/ramdisk

RANDOM=$$
while :
do

A=$(($RANDOM % 4))
echo $A

sudo pkill -f start
sudo pkill -f sa
sudo pkill -f 10k
sudo pkill -f adf4351


if [[ $A == 0 ]]
then
bash /home/pi/Desktop/startall.sh&
sleep 10
fi


if [[ $A == 1 ]]
then
bash /home/pi/Desktop/sa.sh&
sleep 10
fi


if [[ $A == 2 ]]
then
bash /home/pi/Desktop/startDLPFC.sh&
sleep 10
fi
done


if [[ $A == 3 ]]
then
bash /home/pi/Desktop/startPTSD.sh&
sleep 10
fi
done