#!/bin/bash

# Path to the file
FILE="/home/pi/Desktop/nvalues.txt"

# Default values
DEFAULT_T1=140
DEFAULT_T2=65

# Check if file exists and load values, otherwise use defaults
if [[ -f "$FILE" ]]; then
    # Read first two values from the file
    read T1 T2 < "$FILE"
else
    T1=$DEFAULT_T1
    T2=$DEFAULT_T2
fi


T3=$((T1*5))
T4=$((T2*4))

# Path to the file
FILE="/home/pi/Desktop/10values.txt"

# Default values
DEFAULT_T3=140
DEFAULT_T4=65

# Check if file exists and load values, otherwise use defaults
if [[ -f "$FILE" ]]; then
    # Read first two values from the file
    read T5 T6 < "$FILE"
else
    T5=$DEFAULT_T3
    T6=$DEFAULT_T4
fi

T7=$((T5*2))
T8=$((T6*2))

cd /tmp/ramdisk

sudo pkill -f adf435
SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED
myarray=(1 2 3 4 5 6 7 8 9)
#shuf -e ${myarray[@]}

#sudo /home/pi/Desktop/loadrdDEW.sh
FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")
else
    # Default to 2 if file not found
    C=2
fi



# --- Define your three sets of numbers ---
set1_t1=(300 400 500)
set1_t2=(600 800 1000)

set2_t1=(40 50 90)
set2_t2=(80 100 120)

set3_t1=(100 200 300)
set3_t2=(200 400 1000)

# Put all sets into arrays of arrays
all_t1=(set1_t1[@] set2_t1[@] set3_t1[@])
all_t2=(set1_t2[@] set2_t2[@] set3_t2[@])

set_index=0   # tracks which set we are on
cycle_count=0 # counts how many total loops run

while true; do
    # Pick the correct set
    current_set_t1=("${!all_t1[$set_index]}")
    current_set_t2=("${!all_t2[$set_index]}")

    # Loop through numbers in the current set
    for i in "${!current_set_t1[@]}"; do
        t1="${current_set_t1[$i]}"
        t2="${current_set_t2[$i]}"

        echo "Set $((set_index+1)) | t1=$t1 | t2=$t2 | cycle=$cycle_count"

        # --- Your logic here ---

T3=$((T1*5))
T4=$((T2*4))
T5=$((T1))
T6=$((T2))
T7=$((T1*2))
T8=$((T2*2))

A=1
#A=1
echo $A



##if [[ $A -gt 0 ]]
##then




echo "Normal Burst" 
A=1600
B=800


/tmp/ramdisk/adf4351 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43512 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43513 1000 25000000 $C $T3 $T4&
/tmp/ramdisk/adf43514 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43515 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43516 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43517 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43518 1000 25000000 $C $T1 $T2&
/tmp/ramdisk/adf43519 1000 25000000 $C $T1 $T2&


echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"
echo "......................N BURST MODE......................"

#sleep 1.$(($RANDOM % 3))
sleep 1

sudo pkill -f adf4351


B=25000
A=8264

echo "10k" 
/tmp/ramdisk/adf43512s 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435132 3000 25000000 $C $T7 $T8&
/tmp/ramdisk/adf435122 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435142 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435152 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435162 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435172 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435182 3000 25000000 $C $T5 $T6&
/tmp/ramdisk/adf435192 3000 25000000 $C $T5 $T6&
D=$(($RANDOM % 30 + 1))
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"
echo "......................10K BURST MODE......................$D"

#sleep 1.$(($RANDOM % 3))
sleep 1

sudo pkill -f adf4351



cycle_count=$((cycle_count+1))
echo cycle count $cycle_count

        # After 10 cycles, move to the next set
        if (( cycle_count >= $(($RANDOM % 7 + 7)) )); then
            set_index=$(( (set_index + 1) % 3 ))
            echo "---- Switching to set $((set_index+1)) ----"
		cycle_count=0
        fi
    done
done
