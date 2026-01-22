#!/bin/bash




RANDOM=$$

while :
do
cd /home/pi/Desktop
#RANDOM=$$

sudo pkill -f sa.sh
sudo pkill -f sa2.sh
sudo pkill -f sa4.sh
sudo pkill -f sa5.sh
sudo pkill -f sa6.sh
sudo pkill -f sa7.sh
sudo pkill -f sa8.sh
sudo pkill -f sa9.sh
sudo pkill -f sa10.sh
sudo pkill -f sa11.sh
sudo pkill -f adf4351
sudo pkill -f start
sudo pkill -f 10k


A=$(($RANDOM % 8))

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
bash /home/pi/Desktop/10k4/10k.sh&
sleep 1
fi

if [[ $A == 7 ]]
then
bash /home/pi/Desktop/n4/startall.sh&
sleep 1
fi



done
