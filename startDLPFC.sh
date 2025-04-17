clear
cd /home/pi/Desktop/testmodules
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********
echo  **********----------DLPFC RUNNING----------**********

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED



two=1900
one=1600


while :
do

BB=$(($RANDOM%$(($two-$one)) + $one))

C=0

for (( i=1; i<=27; i++ ))
do
offset=$(($offset + RANDOM % 900000))
done

#echo $offset


BB=366
BB1=$(($BB+1))
BB2=$(($BB+2))
BB3=$(($BB+3))


hz1=2
hz2=3
hz3=4
hz4=5


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
sleep 1
exit

done
