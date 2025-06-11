cd /home/pi/Desktop/testmodules

echo QUAD H.

# Function to load and shuffle numbers into an array
load_and_shuffle_array() {
    # Use 'shuf' to randomly shuffle lines before storing them
    mapfile -t numbers < <(grep -v '^[[:space:]]*$' /tmp/ramdisk/SG3.TXT | shuf)
    # Track the size of the array
    size=${#numbers[@]}
    # Start index back at 0
    index=0
}

# Initial load and shuffle
load_and_shuffle_array

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED


mapfile -t numbers < <(grep -v '^[[:space:]]*$' /tmp/ramdisk/SG3.TXT | shuf)
index=0
size=$((${#numbers[@]}-2))


while :
do

    # Increment the index
    ((index++))

    # If we've reached the end, reshuffle
    if [ "$index" -ge "$size" ]; then
        load_and_shuffle_array
    fi
   
    BB=${numbers[$index]}
echo $BB




#BB=$(($RANDOM%$(($2-$1)) + $1))

C=0


offset=500000
#echo $offset

#echo $offset



BB1=$(($BB+1))
BB2=$(($BB+2))
BB3=$(($BB+3))


hz1=5
hz2=7
hz3=5
hz4=7

x=$((RANDOM % 2 + 1))


#echo $BB1.$offset
#echo $BB1.$(($offset+$hz1))
echo QUAD H.


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
sleep 0.07

done


