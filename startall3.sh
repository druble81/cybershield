#!/bin/bash




FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi

/home/pi/Desktop/startall3/adf4351 200 25000000 $C&
/home/pi/Desktop/startall3/adf43512 200 25000000 $C&
/home/pi/Desktop/startall3/adf43513 200 25000000 $C&
/home/pi/Desktop/startall3/adf43514 200 25000000 $C&
/home/pi/Desktop/startall3/adf43515 200 25000000 $C&
/home/pi/Desktop/startall3/adf43516 200 25000000 $C&
/home/pi/Desktop/startall3/adf43517 200 25000000 $C&
/home/pi/Desktop/startall3/adf43518 200 25000000 $C&
/home/pi/Desktop/startall3/adf43519 200 25000000 $C&

while :
do


#sudo pkill -f adf4351

echo "PFC"


sleep 10




done
