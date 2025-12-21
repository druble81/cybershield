cd /home/pi/Desktop/testmodules

echo QUAD H.

# Function to load and shuffle numbers into an array
load_and_shuffle_array() {
    mapfile -t numbers < <(grep -v '^[[:space:]]*$' /tmp/ramdisk/SG3.TXT | shuf)
    size=${#numbers[@]}
    index=0
}

# Initial load and shuffle
load_and_shuffle_array

SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED

FILE="/home/pi/Desktop/power.txt"
if [[ -f "$FILE" ]]; then
    C=$(<"$FILE")
else
    C=2
fi


hz1="000005"
hz2="000006"
hz3="000020"
hz4="000130"

while :
do
    # If index at end → reshuffle
    if (( index >= size )); then
        load_and_shuffle_array
    fi

    BB=${numbers[$index]}

    BB1=$((BB))
    BB2=$((BB+1))
    BB3=$((BB))

    echo "Random number selected: $BB"
    echo "Random number selected: $BB1"
    echo "Random number selected: $BB2"
    echo "Random number selected: $BB3"

    echo QUAD H.

    # ---- 8 MODULE COMMANDS ----

    ./adf4351  $BB                  25000000 $C &
    ./adf43512 $BB.$hz1          25000000 $C &
    ./adf43513 $BB1.$hz2         25000000 $C &
    ./adf43514 $BB1                 25000000 $C &
    ./adf43515 $BB2                 25000000 $C &
    ./adf43516 $BB2.$hz3         25000000 $C &
    ./adf43517 $BB3.$hz4         25000000 $C &
    ./adf43518 $BB3                 25000000 $C &

    # sleep after each block
    sleep 0.2

    ((index++))
done
