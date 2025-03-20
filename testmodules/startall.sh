cd /home/pi/Desktop/testmodules

echo QUAD H.

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED


while :
do
BA=$((RANDOM % 99 + 1))
##BA=33
BB=$((RANDOM % 20 + 1))
#BB=$(($BB)) 
#BB=3
BB=$(($RANDOM%$(($2-$1)) + $1))

C=0


offset=500000
#echo $offset

#echo $offset



BB1=$(($BB))
BB2=$(($BB))
BB3=$(($BB))


hz1=4
hz2=3
hz3=1
hz4=2


#echo $BB1.$offset
#echo $BB1.$(($offset+$hz1))



BB44=$(($RANDOM%3+1))



#./adf43519 4130 25000000 $C


./adf4351 $BB.$offset 25000000 $C&
./adf43512 $BB.$(($offset+$hz1)) 25000000 $C&
##100000

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

####################10001

#10000 - 100001 = 1hz#
sleep 5

done


