#!/bin/bash
cd /home/pi/Desktop/testmodules || exit 1

# ----------------------------------------
# RANDOM SEED (strong entropy)
# ----------------------------------------
SEED=$(od -An -N2 -i /dev/urandom)
RANDOM=$SEED

# ----------------------------------------
# POWER LEVEL
# ----------------------------------------
FILE="/home/pi/Desktop/power.txt"
if [[ -f "$FILE" ]]; then
    C=$(<"$FILE")
else
    C=2
fi

# ----------------------------------------
# FIXED OFFSETS
# ----------------------------------------
hz1="008000"
hz2="010000"
hz3="009000"
hz4="000380"

# ----------------------------------------
# RANGE DEFINITIONS
# format: BASE WIDTH
# ----------------------------------------
RANGES=(
  "495 10"
  "4200 200"
  "85 55"
  "4200 190"
  "950 100"
  "1500 200"
  "3000 200"
  "3400 200"
  "3800 200"
  "4000 195"
  "85 35"
)

# ----------------------------------------
# SHUFFLE RANGES (fast global coverage)
# ----------------------------------------
shuffle_ranges() {
  mapfile -t SHUFFLED < <(printf "%s\n" "${RANGES[@]}" | shuf)
}
shuffle_ranges

RANGE_INDEX=0

# ----------------------------------------
# PHASE-ROTATED BIN STEPPING
# ----------------------------------------
SUB_BINS=8            # number of bins per range
BIN_INDEX=0           # stepping index
PHASE=0               # rotating phase offset

while :
do
    # ----------------------------
    # SELECT RANGE
    # ----------------------------
    IFS=" " read BASE WIDTH <<< "${SHUFFLED[$RANGE_INDEX]}"

    RANGE_INDEX=$((RANGE_INDEX + 1))
    if (( RANGE_INDEX >= ${#SHUFFLED[@]} )); then
        RANGE_INDEX=0
        shuffle_ranges
        PHASE=$(( (PHASE + 1) % SUB_BINS ))   # 🔄 phase rotation
    fi

    # ----------------------------
    # BIN + PHASE COMPUTATION
    # ----------------------------
    BIN_WIDTH=$(( WIDTH / SUB_BINS ))
    BIN=$(( (BIN_INDEX + PHASE) % SUB_BINS ))

    BB=$(( BASE + BIN * BIN_WIDTH + RANDOM % BIN_WIDTH ))

    BIN_INDEX=$(( (BIN_INDEX + 1) % SUB_BINS ))

    BB1=$BB
    BB2=$BB
    BB3=$BB

    # ----------------------------
    # TRANSMIT (UNCHANGED CALLS)
    # ----------------------------
    ./adf4351  $BB        25000000 $C &
    ./adf43512 $BB.$hz1   25000000 $C &
    ./adf43513 $BB1.$hz2  25000000 $C &
    ./adf43514 $BB1       25000000 $C &
    ./adf43515 $BB2       25000000 $C &
    ./adf43516 $BB2.$hz3  25000000 $C &
    ./adf43517 $BB3.$hz4  25000000 $C &
    ./adf43518 $BB3       25000000 $C

    # ----------------------------
    # JITTERED DWELL (UNCHANGED)
    # ----------------------------
    sleep 0.0000$((RANDOM % 9 + 1))$((RANDOM % 9 + 1))$((RANDOM % 9 + 1))
echo V2K

done
