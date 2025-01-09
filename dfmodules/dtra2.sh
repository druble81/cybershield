#!/bin/bash

cd /home/pi/Desktop/dfmodules


RANDOM=$$

while :
do
#RANDOM=$$
sudo pkill -f t22.sh
sudo pkill -f t23.sh
sudo pkill -f t24.sh
sudo pkill -f adf4351



A=$(($RANDOM % 3))
#A=1

echo $A
echo $A
echo $A
echo $A
echo $A

if [[ $A == 0 ]]
then
bash  t22.sh&
sleep $(($RANDOM % 4 + 2))
fi

if [[ $A == 1 ]]
then
bash  t23.sh&
sleep $(($RANDOM % 3 + 3))
fi

if [[ $A == 2 ]]
then
bash  t24.sh&
sleep $(($RANDOM % 5 + 2))
fi

done





