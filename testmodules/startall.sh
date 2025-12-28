cd /home/pi/Desktop/testmodules

echo QUAD H.

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

GROUP_STEP=10     # 100 MHz groups
CURRENT_GROUP=$MIN_BB
GROUP_DIR=1        # 1 = up, -1 = down

GROUP_HOLD=20      # loops per group
GROUP_COUNT=0


FILE="/home/pi/Desktop/power.txt"
if [[ -f "$FILE" ]]; then
    C=$(<"$FILE")
else
    C=2
fi


hz1="007000"
hz2="000006"
hz3="000020"
hz4="000130"

echo QUAD H.

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


    BB1=$((BB))
    BB2=$((BB+1))
    BB3=$((BB))

    #echo "Random number selected: $BB"
    #echo "Random number selected: $BB1"
    #echo "Random number selected: $BB2"
    #echo "Random number selected: $BB3"

    

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
    sleep 0.00000$((RANDOM % 9+ 1))$((RANDOM % 9+ 1))$((RANDOM % 9+ 1))

   done
