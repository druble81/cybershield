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
clear


#!/bin/bash

# Accept two input arguments
val1=$1
val2=$2

# Calculate the absolute difference
diff=$(( val1 > val2 ? val1 - val2 : val2 - val1 ))

# Determine the value of B based on the difference
if [ "$diff" -lt 100 ]; then
    B=5
elif [ "$diff" -ge 100 ] && [ "$diff" -lt 500 ]; then
    B=10

elif [ "$diff" -ge 500 ] && [ "$diff" -lt 1000 ]; then
    B=15
elif [ "$diff" -ge 1000 ] && [ "$diff" -lt 1500 ]; then
    B=20
elif [ "$diff" -ge 1500 ] && [ "$diff" -lt 2000 ]; then
    B=25
elif [ "$diff" -ge 2000 ] && [ "$diff" -lt 2500 ]; then
    B=30
elif [ "$diff" -ge 2500 ] && [ "$diff" -lt 3000 ]; then
    B=35
elif [ "$diff" -ge 3000 ] && [ "$diff" -lt 3500 ]; then
    B=40
elif [ "$diff" -ge 3500 ] && [ "$diff" -lt 4000 ]; then
    B=45
else
    B=65
fi

# Output the result
echo "$A"


rand_num=$((RANDOM % 11))
A=$(($1 + rand_num))


while [[ $A -lt $2 ]]
do
printf "%s\n" $A   >> /tmp/ramdisk/SG3.TXT



A=$(($A+$(($B))))

done
printf "\n"    >> /tmp/ramdisk/SG3.TXT
A=900
echo done setting primaries
echo b is $B
exit


 
