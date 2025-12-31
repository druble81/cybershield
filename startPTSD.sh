#!/bin/bash
cd /home/pi/Desktop/testmodules

FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi

echo "C is set to: $C"


cd /home/pi/Desktop/testmodules

clear
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********
echo  **********----------ANTI PTSD RUNNING----------**********


#!/bin/bash


# Read all numbers from SG3.TXT into array
mapfile -t numbers < <(grep -Eo '[0-9]+' /tmp/ramdisk/SG3.TXT)

# Validate
if [ "${#numbers[@]}" -eq 0 ]; then
    echo "No numbers found in /tmp/ramdisk/SG3.TXT"
    exit 1
fi

# ---- MIN / MAX FROM FILE (FIRST AND LAST) ----
MIN_BB="${numbers[0]}"
MAX_BB="${numbers[${#numbers[@]}-1]}"

GROUP_STEP=25     # 100 MHz groups
CURRENT_GROUP=$MIN_BB
GROUP_DIR=1        # 1 = up, -1 = down

GROUP_HOLD=25      # loops per group
GROUP_COUNT=0





two=1005
one=998


while :
do


# ---- GROUP HOLD COUNTER ----
GROUP_COUNT=$((GROUP_COUNT + 1))

if (( GROUP_COUNT >= GROUP_HOLD )); then
    GROUP_COUNT=0
    CURRENT_GROUP=$((CURRENT_GROUP + GROUP_DIR * GROUP_STEP))

    # Reverse direction at bounds
    if (( CURRENT_GROUP >= MAX_BB )); then
        CURRENT_GROUP=$MAX_BB
        GROUP_DIR=-1
    elif (( CURRENT_GROUP <= MIN_BB )); then
        CURRENT_GROUP=$MIN_BB
        GROUP_DIR=1
    fi
fi

# ---- RANDOMIZE WITHIN CURRENT GROUP ----
BB=$(( CURRENT_GROUP + RANDOM % GROUP_STEP ))

echo "BB Group: $CURRENT_GROUP  |  BB: $BB"


offset=700000

BB1=$(($BB+2))
BB2=$(($BB+1))
BB3=$(($BB+3))


hz1=120
hz2=5
hz3=$(($RANDOM % 2 + 19))
hz4=420


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
./adf43516 $BB2.$(($offset+$hz3)) 25000000 $C&
#echo ./adf43516 $BB".210001" 25000000 $C&
##210001

./adf43517 $BB3.$(($offset+$hz4)) 25000000 $C&
./adf43518 $BB3.$offset 25000000 $C
##200003

####################10001
#10000 - 100001 = 1hz#
sleep 0.0000$(($RANDOM % 9))$(($RANDOM % 9))$(($RANDOM % 9))

done
