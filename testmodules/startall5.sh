cd /home/pi/Desktop/testmodules
#bash /home/pi/Desktop/alloffrd.sh

echo sleep 5

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED



two=102
one=98

BB=$(($RANDOM%$(($two-$one)) + $one))

while :
do



C=0

offset=500000

#echo $offset



BB1=$(($BB))
BB2=$(($BB))
BB3=$(($BB))


hz1=$(($RANDOM%3+9))
hz2=2
hz3=2
hz4=2


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
./adf43512 off
./adf4351 off
####################10001

#10000 - 100001 = 1hz#
sleep 0.05

done






