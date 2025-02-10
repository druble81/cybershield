#!/bin/bash

cd /home/pi/Desktop

cat /dev/null > /tmp/ramdisk/SG3.TXT


A=35

while [[ $A -lt 162 ]]
do
printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
A=$(($A+$((1))))
echo loop 1
done
A=225
while [[ $A -lt 401 ]]
do
printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
A=$(($A+$((1))))
done
A=600
while [[ $A -lt 1901 ]]
do
printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT
A=$(($A+$((1))))
done


echo done setting primaries
printf "\n"    >> /tmp/ramdisk/SG3.TXT
A=900
exit


 
