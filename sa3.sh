#!/bin/bash


cd /home/pi/Desktop


RANDOM=$$

while :
do
#RANDOM=$$
sudo pkill -f sa2.sh
sudo pkill -f sa.sh
sudo pkill -f startall2.sh
sudo pkill -f startDLPFC.sh
sudo pkill -f startPTSD.sh
sudo pkill -f adf4351
sudo pkill -f startall
sudo pkill -f 10k


A=$(($RANDOM % 12))

if [[ $A == 0 ]]
then
bash startall.sh&
sleep 1
fi

if [[ $A == 1 ]]
then
bash startall2.sh&
sleep 1
fi

if [[ $A == 2 ]]
then
bash startDLPFC.sh&
sleep 1
fi

if [[ $A == 3 ]]
then
bash startPTSD.sh&
sleep 1
fi

if [[ $A == 4 ]]
then
bash /home/pi/Desktop/testmodules/startall2.sh&
sleep 1
fi

if [[ $A == 5 ]]
then
bash 10k.sh&
sleep 1
fi

if [[ $A == 6 ]]
then
bash /home/pi/Desktop/10k2/10k.sh&
sleep 1
fi

if [[ $A == 7 ]]
then
bash /home/pi/Desktop/10k3/10k.sh&
sleep 1
fi

if [[ $A == 8 ]]
then
bash /home/pi/Desktop/10k4/10k.sh&
sleep 1
fi

if [[ $A == 9 ]]
then
bash /home/pi/Desktop/n2/startall.sh&
sleep 1
fi

if [[ $A == 10 ]]
then
bash /home/pi/Desktop/n3/startall.sh&
sleep 1
fi

if [[ $A == 11 ]]
then
bash /home/pi/Desktop/n4/startall.sh&
sleep 1
fi



done
