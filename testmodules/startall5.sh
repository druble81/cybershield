cd /home/pi/Desktop/testmodules
#bash /home/pi/Desktop/alloffrd.sh

echo sleep 5

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED



two=500
one=90

BB=$(($RANDOM%$(($two-$one)) + $one))


FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi

echo "C is set to: $C"


while :
do



offset=500000

#echo $offset

BB=$(($RANDOM%$(($two-$one)) + $one))

BB1=$(($BB))
BB2=$(($BB))
BB3=$(($BB))


hz1=1
hz2=2
hz3=1
hz4=1


#echo $BB1.$offset
#echo $BB1.$(($offset+$hz1))




./adf43513 $BB1.$(($offset+$hz2)) 25000000 $C&
./adf43514 $BB1.$offset 25000000 $C&
##110000

####################10000

./adf43515 $BB2.$offset 25000000 $C&
./adf43516 $BB2.$(($offset+$hz3))25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$(($offset+$hz4)) 25000000 $C&
./adf43518 $BB3.$offset 25000000 $C
##200003
./adf4351 $BB.$offset 25000000 $C&
./adf43512 $BB.$(($offset+$hz1)) 25000000 $C&
##100000
sleep 0.1

####################10001

#10000 - 100001 = 1hz#
sleep $(($RANDOM%5+1))

done






