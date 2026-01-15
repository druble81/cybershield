#!/bin/bash

cd /home/pi/Desktop/testmodules

#!/bin/bash

# Only pass $1 if it exists
if [ -n "$1" ]; then
    python3 /home/pi/Desktop/startall6.py "$1"
else
    python3 /home/pi/Desktop/startall6.py
fi



exit
done

echo "**********----------WAKE- RUNNING----------**********"

FILE="/home/pi/Desktop/power.txt"
if [[ -f "$FILE" ]]; then
    C=$(<"$FILE")
else
    C=2
fi

two=150
one=430

hz1=10
hz2=11
hz3=15
hz4=19

# --- Determine gethz value ---
if [[ -n "$1" ]]; then
    gethz=$1
else
    gethz=$(python3 /home/pi/Desktop/selecthz.py)
fi

echo "[Wake] Using gethz = $gethz"

# --------------------------------------------------
# MODE: argument == 0 → bidirectional 18–25 Hz
# --------------------------------------------------
if [[ "$gethz" -eq 0 ]]; then
    hz1=18
    direction=1   # 1 = up, -1 = down

    while :
    do
        BB=$(($RANDOM % ($two - $one + 1) + $one))
        offset=$((RANDOM % (990000 - 100000 + 1) + 100000))

        hz2=$hz1
        hz3=$hz1
        hz4=$hz1

        ./adf4351   $BB.$offset               25000000 $C &
        ./adf43512  $BB.$(($offset+hz1))      25000000 $C &
        ./adf43513  $BB.$(($offset+hz2))      25000000 $C &
        ./adf43514  $BB.$offset               25000000 $C &
        ./adf43515  $BB.$offset               25000000 $C &
        ./adf43516  $BB.$(($offset+hz3))      25000000 $C &
        ./adf43517  $BB.$(($offset+hz4))      25000000 $C &
        ./adf43518  $BB.$offset               25000000 $C &

        echo "[Cascade] hz = $hz1"

        # Bounce logic
        if [[ "$hz1" -ge 25 ]]; then
            direction=-1
        elif [[ "$hz1" -le 18 ]]; then
            direction=1
        fi

        hz1=$((hz1 + direction))

        # Slightly different random delay (20–60 ms)
        sleep_ms=$((RANDOM % 40 + 20))
        sleep 0.$(printf "%02d" "$sleep_ms")
    done
fi

# --------------------------------------------------
# NORMAL MODE (unchanged behavior)
# --------------------------------------------------
while :
do
    BB=$(($RANDOM % ($two - $one + 1) + $one))
    offset=$((RANDOM % (990000 - 100000 + 1) + 100000))

    hz1=$((hz1 + 1))

    if [[ "$hz1" -gt "$gethz" ]]; then
        hz1=0
        exit
    fi

    hz2=$hz1
    hz3=$hz1
    hz4=$hz1

    ./adf4351   $BB.$offset               25000000 $C &
    ./adf43512  $BB.$(($offset+hz1))      25000000 $C &
    ./adf43513  $BB.$(($offset+hz2))      25000000 $C &
    ./adf43514  $BB.$offset               25000000 $C &
    ./adf43515  $BB.$offset               25000000 $C &
    ./adf43516  $BB.$(($offset+hz3))      25000000 $C &
    ./adf43517  $BB.$(($offset+hz4))      25000000 $C &
    ./adf43518  $BB.$offset               25000000 $C &

    sleep 0.05
    echo "hz1 = $hz1"
done
