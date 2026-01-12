#!/bin/bash
cd /home/pi/Desktop/testmodules


python3 startallf.sh


done
exit

echo "Starting 8-module hierarchical heterodyne cascade..."

# --- Read SG3 base frequencies into array ---
mapfile -t numbers < <(grep -Eo '[0-9]+' /tmp/ramdisk/SG3.TXT)

# Validate
if [ "${#numbers[@]}" -eq 0 ]; then
    echo "No numbers found in /tmp/ramdisk/SG3.TXT"
    exit 1
fi

# --- Determine min/max ---
MIN_BB="${numbers[0]}"
MAX_BB="${numbers[${#numbers[@]}-1]}"

# --- Timing / Control ---
GROUP_STEP=100     # Frequency group step
CURRENT_GROUP=$MIN_BB
GROUP_DIR=1        # 1 = up, -1 = down
GROUP_HOLD=25
GROUP_COUNT=0

FILE="/home/pi/Desktop/power.txt"
if [[ -f "$FILE" ]]; then
    C=$(<"$FILE")
else
    C=2
fi

# --- Layered heterodyne offsets ---
O1=1   # First layer ± offset
O2=2   # Second layer ± offset
O3=4   # Third layer ± offset
JITTER=1  # optional ±1 Hz micro jitter

# Infinite loop
while :; do
    # --- Group hold logic ---
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

    # --- Base frequency within current group ---
    BB=$(( CURRENT_GROUP + RANDOM % GROUP_STEP ))
    echo "BB Group: $CURRENT_GROUP  |  BB: $BB"

O1=0.000003      # Layer 1 offset in MHz = 3 Hz
O2=0.010000      # Layer 2 offset in MHz = 10 kHz
O3=0.000003      # Layer 3 offset in MHz = 3 Hz

# Layer 1
FREQ1=$(echo "$BB + $O1" | bc -l)
FREQ2=$(echo "$BB - $O1" | bc -l)

# Layer 2
FREQ3=$(echo "$FREQ1 + $O2" | bc -l)
FREQ4=$(echo "$FREQ1 - $O2" | bc -l)
FREQ5=$(echo "$FREQ2 + $O2" | bc -l)
FREQ6=$(echo "$FREQ2 - $O2" | bc -l)

# Layer 3
FREQ7=$(echo "$FREQ3 + $O3" | bc -l)
FREQ8=$(echo "$FREQ4 - $O3" | bc -l)

    # --- Run modules (synchronously, wait for all) ---
    ./adf4351  $BB       25000000 $C &
    sleep 0.001
    ./adf43512 $FREQ1   25000000 $C &
    sleep 0.001
    ./adf43513 $FREQ2   25000000 $C &
    sleep 0.001
    ./adf43514 $FREQ3   25000000 $C &
    sleep 0.001
    ./adf43515 $FREQ4   25000000 $C &
    sleep 0.001
    ./adf43516 $FREQ5   25000000 $C &
    sleep 0.001
    ./adf43517 $FREQ6   25000000 $C &
    sleep 0.001
    ./adf43518 $FREQ7   25000000 $C &
    

    # Wait for all modules to complete update
    wait

    # --- Optional random sleep for timing jitter ---
    sleep 0.00$((RANDOM % 9 + 1))$((RANDOM % 9 + 1))
done
