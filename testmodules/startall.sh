#!/bin/bash
cd /home/pi/Desktop/testmodules

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
GROUP_STEP=25     # Frequency group step
CURRENT_GROUP=$MIN_BB
GROUP_DIR=1        # 1 = up, -1 = down
GROUP_HOLD=$((RANDOM % 50 + 50))
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

    # --- Layer 1: Modules 1-2 ---
    FREQ1=$(( BB + O1 + RANDOM % (2*JITTER+1) - JITTER ))
    FREQ2=$(( BB - O1 + RANDOM % (2*JITTER+1) - JITTER ))

    # --- Layer 2: Modules 3-6 ---
    FREQ3=$(( FREQ1 + O2 + RANDOM % (2*JITTER+1) - JITTER ))
    FREQ4=$(( FREQ1 - O2 + RANDOM % (2*JITTER+1) - JITTER ))
    FREQ5=$(( FREQ2 + O2 + RANDOM % (2*JITTER+1) - JITTER ))
    FREQ6=$(( FREQ2 - O2 + RANDOM % (2*JITTER+1) - JITTER ))

    # --- Layer 3: Modules 7-8 ---
    FREQ7=$(( FREQ3 + O3 + RANDOM % (2*JITTER+1) - JITTER ))
    FREQ8=$(( FREQ4 - O3 + RANDOM % (2*JITTER+1) - JITTER ))

    # --- Run modules (synchronously, wait for all) ---
    ./adf4351  $BB       25000000 $C &
    ./adf43512 $FREQ1   25000000 $C &
    ./adf43513 $FREQ2   25000000 $C &
    ./adf43514 $FREQ3   25000000 $C &
    ./adf43515 $FREQ4   25000000 $C &
    ./adf43516 $FREQ5   25000000 $C &
    ./adf43517 $FREQ6   25000000 $C &
    ./adf43518 $FREQ7   25000000 $C &

    # Wait for all modules to complete update
    wait

    # --- Optional random sleep for timing jitter ---
    sleep 0.0000$((RANDOM % 9 + 1))$((RANDOM % 9 + 1))$((RANDOM % 9 + 1))
done
