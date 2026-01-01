cd /home/pi/Desktop/testmodules
#bash /home/pi/Desktop/alloffrd.sh

echo sleep

BB=85
BB1=110
BB2=300
BB3=900

FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi



./adf4351 $BB 25000000 $C
./adf43512 $BB.000003 25000000 $C
#./adf43513 $BB1 25000000 $C
#./adf43514 $BB1.000003 25000000 $C
#./adf43515 $BB2 25000000 $C
#./adf43516 $BB2.000003 25000000 $C
#./adf43517 $BB3 25000000 $C
#./adf43518 $BB3.000003 25000000 $C
##100000
