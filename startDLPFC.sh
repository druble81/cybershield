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
# Read all non-empty lines (assumed to be numbers) into an array
mapfile -t numbers < <(grep -Eo '[0-9]+' /tmp/ramdisk/SG3.TXT)

# Check if the array has at least one number
if [ "${#numbers[@]}" -eq 0 ]; then
    echo "No numbers found in /tmp/ramdisk/SG3.TXT"
    exit 1
fi

# Randomly pick a number and assign to BB
BB="${numbers[$RANDOM % ${#numbers[@]}]}"

# (Optional) Echo it to verify
#echo "Random number selected: $BB"



two=1005
one=998


while :
do

BB="${numbers[$RANDOM % ${#numbers[@]}]}"
echo "Random number selected: $BB"


offset=500000


BB=998
BB1=$(($BB+1))
BB2=$(($BB+2))
BB3=$(($BB+3))


hz1=3
hz2=2
hz3=1
hz4=2

#echo $BB1.$offset
#echo $BB1.$(($offset+$hz1))

C=2


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
sleep 0.4

done
