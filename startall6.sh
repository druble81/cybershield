cd /home/pi/Desktop/testmodules
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********
echo  **********----------WAKE- RUNNING----------**********

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED



two=2000
one=85


while :
do

BB=$(($RANDOM%$(($two-$one)) + $one))

C=3


offset=500000


#echo $offset



BB1=$(($BB))
BB2=$(($BB))
BB3=$(($BB))


hz1=8
hz2=8
hz3=8
hz4=11

#echo $BB1.$offset
#echo $BB1.$(($offset+$hz1))



BB44=$(($RANDOM%3+1))





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
sleep 0.$BB44

done
