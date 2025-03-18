#!/bin/bash

sudo bash /home/pi/Desktop/ramdisk.sh
cd /home/pi/Desktop
bash fixpermissions.sh
cp 10k/adf4351 /tmp/ramdisk/adf43512s
cp 10k/adf43512 /tmp/ramdisk/adf435122
cp 10k/adf43513 /tmp/ramdisk/adf435132
cp 10k/adf43514 /tmp/ramdisk/adf435142
cp 10k/adf43515 /tmp/ramdisk/adf435152
cp 10k/adf43516 /tmp/ramdisk/adf435162
cp 10k/adf43517 /tmp/ramdisk/adf435172
cp 10k/adf43518 /tmp/ramdisk/adf435182
cp 10k/adf43519 /tmp/ramdisk/adf435192
cp alloffrd.sh /tmp/ramdisk/alloffrd.sh
cp /bin/pkill /tmp/ramdisk/pkill

cp adf4351 /tmp/ramdisk/adf4351
cp adf43512 /tmp/ramdisk/adf43512
cp adf43513 /tmp/ramdisk/adf43513
cp adf43514 /tmp/ramdisk/adf43514
cp adf43515 /tmp/ramdisk/adf43515
cp adf43516 /tmp/ramdisk/adf43516
cp adf43517 /tmp/ramdisk/adf43517
cp adf43518 /tmp/ramdisk/adf43518
cp adf43519 /tmp/ramdisk/adf43519
cp loadrd.sh /tmp/ramdisk/loadrd.sh

cat /dev/null > /tmp/ramdisk/SG3.TXT

A=300

while [[ $A -lt 400 ]]
do
 printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
A=$(($A+5))
done
/home/pi/Desktop/dfmodules/dfmenu&
exit
A=900
