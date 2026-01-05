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
# FIXED OFFSETS (HETERODYNE MAGNITUDES)
# ----------------------------------------
hz1="00800"     # Layer 1
hz2="010000"    # Layer 2
hz3="009000"    # Layer 2
hz4="000005"    # Layer 3 (collapse)

# ----------------------------------------
# RANGE DEFINITIONS
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
  "4400 4200"
  "85 35"
)

# ----------------------------------------
# SHUFFLE RANGES
# ----------------------------------------
shuffle_ranges() {
  mapfile -t SHUFFLED < <(printf "%s\n" "${RANGES[@]}" | shuf)
}
shuffle_ranges
RANGE_INDEX=0

# ----------------------------------------
# PHASE-ROTATED BIN STEPPING
# ----------------------------------------
SUB_BINS=8
BIN_INDEX=0
PHASE=0

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
        PHASE=$(( (PHASE + 1) % SUB_BINS ))
    fi

    # ----------------------------
    # BIN + PHASE COMPUTATION
    # ----------------------------
    BIN_WIDTH=$(( WIDTH / SUB_BINS ))
    BIN=$(( (BIN_INDEX + PHASE) % SUB_BINS ))

    BB=$(( BASE + BIN * BIN_WIDTH + RANDOM % BIN_WIDTH ))
    BIN_INDEX=$(( (BIN_INDEX + 1) % SUB_BINS ))

    # ==================================================
    # 🔗 HIERARCHICAL HETERODYNE CASCADE
    # ==================================================

    # ----- Layer 1 (2 → 4 freqs) -----
    L1A="$BB.$hz1$((RANDOM % 2 + 1))"
    L1B="$BB.$hz1$((RANDOM % 2 + 1))"

    # ----- Layer 2 (4 → 2 freqs) -----
    L2A="$BB.$hz2"
    L2B="$BB.$hz3"

    # ----- Layer 3 (2 → 1 collapse) -----
    L3="$BB.$hz4"

    # ----------------------------
    # TRANSMIT (CASCADED)
    # ----------------------------
    ./adf4351   $BB        25000000 $C &   # Primary

    # Layer 1
    ./adf43512  $L1A       25000000 $C &
    ./adf43513  $L1B       25000000 $C &

    # Layer 2
    ./adf43514  $L2A       25000000 $C &
    ./adf43515  $L2A       25000000 $C &
    ./adf43516  $L2B       25000000 $C &
    ./adf43517  $L2B       25000000 $C &

    # Layer 3 (final convergence)
    ./adf43518  $L3        25000000 $C

    # ----------------------------
    # JITTERED DWELL
    # ----------------------------
    sleep 0.0$((RANDOM % 9 + 1))$((RANDOM % 9 + 1))
    echo "V2K"

done
