#!/bin/bash

cd /home/pi/Desktop/dfmodules


RANDOM=$$

while :
do
#RANDOM=$$
sudo pkill -f t18.sh
sudo pkill -f t19.sh
sudo pkill -f t20.sh
sudo pkill -f t21.sh
sudo pkill -f adf4351



A=$(($RANDOM % 4))
#A=1

echo $A
echo $A
echo $A
echo $A
echo $A

if [[ $A == 0 ]]
then
bash  t18.sh&
sleep $(($RANDOM % 4 + 2))
fi

if [[ $A == 1 ]]
then
bash  t19.sh&
sleep $(($RANDOM % 3 + 3))
fi

if [[ $A == 2 ]]
then
bash  t20.sh&
sleep $(($RANDOM % 5 + 2))
fi

if [[ $A == 3 ]]
then
bash  t21.sh&
sleep $(($RANDOM % 5 + 2))
fi


done





