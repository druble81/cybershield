cd /home/pi/Desktop/testmodules
#bash /home/pi/Desktop/alloffrd.sh

echo sleep 5



two=500
one=90

BB=$(($RANDOM%$(($two-$one+1)) + $one))


FILE="/home/pi/Desktop/power.txt"

if [[ -f "$FILE" ]]; then
    # Read the value from the file into C
    C=$(<"$FILE")#!/bin/bash

cd /home/pi/Desktop/testmodules

# -------------------------------
# USER TUNABLES
# -------------------------------

TARGET_HZ=1          # final beat frequency to converge to
START_HZ=12          # starting beat frequency
STEP_HZ=1            # ramp step
DWELL_BASE=6         # base dwell seconds
DWELL_VAR=4          # random additional dwell
PHASE_STEP=3         # phase rotation increment (Hz offset)

REFCLK=25000000
POWER_FILE="/home/pi/Desktop/power.txt"
SG3_FILE="/tmp/ramdisk/SG3.TXT"

# -------------------------------
# POWER LEVEL
# -------------------------------

if [[ -f "$POWER_FILE" ]]; then
    C=$(<"$POWER_FILE")
else
    C=2
fi

# -------------------------------
# RANGE FROM SG3
# -------------------------------

MIN=$(head -n 1 "$SG3_FILE")
MAX=$(tail -n 1 "$SG3_FILE")

echo "SG3 Range: $MIN to $MAX"
echo "Power: $C"

# -------------------------------
# MODULE GROUPS
# -------------------------------

GROUP1=(adf43513 adf43514 adf43515 adf43516)
GROUP2=(adf43517 adf43518 adf4351  adf43512)

# -------------------------------
# INITIAL VALUES
# -------------------------------

CURRENT_HZ=$START_HZ
PHASE=0

# -------------------------------
# MAIN LOOP
# -------------------------------

while true; do

    # Clamp current hz
    if (( CURRENT_HZ < TARGET_HZ )); then
        CURRENT_HZ=$TARGET_HZ
    fi

    # Random base carrier inside SG3 range
    BB=$(($RANDOM % ($MAX - $MIN + 1) + $MIN))

    # Base offset (kept stable)
    OFFSET=$((RANDOM % 500000 + 200000))

    echo "Carrier: $BB  Beat: $CURRENT_HZ Hz  Phase: $PHASE"

    # ---------------------------
    # GROUP 1
    # ---------------------------
    i=0
    for MOD in "${GROUP1[@]}"; do
        ./"$MOD" $BB.$((OFFSET + PHASE + i)) $REFCLK $C &
        ((i+=CURRENT_HZ))
    done

    sleep 1

    # ---------------------------
    # GROUP 2 (phase rotated)
    # ---------------------------
    i=0
    for MOD in "${GROUP2[@]}"; do
        ./"$MOD" $BB.$((OFFSET + PHASE + PHASE_STEP + i)) $REFCLK $C &
        ((i+=CURRENT_HZ))
    done

    # ---------------------------
    # DWELL
    # ---------------------------
    sleep $((DWELL_BASE + RANDOM % DWELL_VAR))

    # ---------------------------
    # PHASE ROTATION
    # ---------------------------
    PHASE=$((PHASE + PHASE_STEP))
    if (( PHASE > 20 )); then
        PHASE=0
    fi

    # ---------------------------
    # RAMP DOWN TOWARD TARGET
    # ---------------------------
    if (( CURRENT_HZ > TARGET_HZ )); then
        CURRENT_HZ=$((CURRENT_HZ - STEP_HZ))
    fi

done

else
    # Default to 2 if file not found
    C=2
fi

echo "C is set to: $C"


while :
do

offset=$((RANDOM % (990000 - 100000 + 1) + 100000))



BB=$(($RANDOM%$(($two-$one+1)) + $one))

BB1=$(($BB))
BB2=$(($BB))
BB3=$(($BB))


hz1=1
hz2=2
hz3=1
hz4=3

./adf43513 $BB.$(($offset+$hz2)) 25000000 $C&
./adf43514 $BB.$offset 25000000 $C&
./adf43515 $BB.$offset 25000000 $C&
./adf43516 $BB.$(($offset+$hz3)) 25000000 $C&
./adf43517 $BB.$(($offset+$hz4)) 25000000 $C&
./adf43518 $BB.$offset 25000000 $C&
./adf4351  $BB.$offset 25000000 $C&
./adf43512 $BB.$(($offset+$hz1)) 25000000 $C&

sleep $(($RANDOM%5+1))

done






