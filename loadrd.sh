#!/bin/bash
sudo bash /home/pi/Desktop/ramdisk.sh
cd /home/pi/Desktop
bash fixpermissions.sh
sudo cp 10k/adf4351 /tmp/ramdisk/adf43512s
sudo cp 10k/adf43512 /tmp/ramdisk/adf435122
sudo cp 10k/adf43513 /tmp/ramdisk/adf435132
sudo cp 10k/adf43514 /tmp/ramdisk/adf435142
sudo cp 10k/adf43515 /tmp/ramdisk/adf435152
sudo cp 10k/adf43516 /tmp/ramdisk/adf435162
sudo cp 10k/adf43517 /tmp/ramdisk/adf435172
sudo cp 10k/adf43518 /tmp/ramdisk/adf435182
sudo cp 10k/adf43519 /tmp/ramdisk/adf435192
sudo cp alloffrd.sh /tmp/ramdisk/alloffrd.sh
sudo cp /bin/pkill /tmp/ramdisk/pkill

sudo cp adf4351 /tmp/ramdisk/adf4351
sudo cp adf43512 /tmp/ramdisk/adf43512
sudo cp adf43513 /tmp/ramdisk/adf43513
sudo cp adf43514 /tmp/ramdisk/adf43514
sudo cp adf43515 /tmp/ramdisk/adf43515
sudo cp adf43516 /tmp/ramdisk/adf43516
sudo cp adf43517 /tmp/ramdisk/adf43517
sudo cp adf43518 /tmp/ramdisk/adf43518
sudo cp adf43519 /tmp/ramdisk/adf43519
sudo cp loadrd.sh /tmp/ramdisk/loadrd.sh

sudo cat /dev/null > /tmp/ramdisk/SG3.TXT


A=$1

while [[ $A -lt $2 ]]
do
sudo printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT



A=$(($A+$((1))))
echo done setting primaries
done
sudo  printf "\n"    >> /tmp/ramdisk/SG3.TXT
A=900
exit


 
