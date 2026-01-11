#!/bin/bash
cd /home/pi/Desktop/testmodules || exit 1
python3 /home/pi/Desktop/testmodules/startall22.sh



exit

#!/bin/bash
cd /home/pi/Desktop/testmodules || exit 1

# ----------------------------------------
# RANDOM SEED
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
# HETERODYNE OFFSETS (MHz)
# ----------------------------------------
O1=0.000003      # Layer 1 ± offset (3 Hz)
O2=0.010000      # Layer 2 ± offset (10 kHz)
O3=0.000005      # Layer 3 collapse ± offset (5 Hz)
JITTER=0.000001  # optional ±1 Hz micro jitter

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
# SUB-BINS / PHASE ROTATION
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
    BB=$(echo "$BASE + $BIN * $BIN_WIDTH + ($RANDOM % $BIN_WIDTH)" | bc -l)
    BIN_INDEX=$(( (BIN_INDEX + 1) % SUB_BINS ))

    # ==================================================
    # HIERARCHICAL HETERODYNE CASCADE
    # ==================================================

    # Layer 1: ±O1 around BB
    L1A=$(echo "$BB + $O1 + ($RANDOM/32768)*$JITTER" | bc -l)
    L1B=$(echo "$BB - $O1 + ($RANDOM/32768)*$JITTER" | bc -l)

    # Layer 2: ±O2 relative to Layer 1
    L2A=$(echo "$L1A + $O2" | bc -l)
    L2B=$(echo "$L1A - $O2" | bc -l)
    L2C=$(echo "$L1B + $O2" | bc -l)
    L2D=$(echo "$L1B - $O2" | bc -l)

    # ----------------------------
    # Layer 3: COLLAPSE
    # Compute **single beat frequency** from all Layer 2 signals
    # Take average as central frequency for final heterodyne output
    # ----------------------------
    SUM=$(echo "$L2A + $L2B + $L2C + $L2D" | bc -l)
    L3=$(echo "scale=9; $SUM / 4" | bc -l)   # average
    # Optional micro jitter for collapse
    L3=$(echo "$L3 + ($RANDOM/32768)*$JITTER" | bc -l)

    # ==================================================
    # TRANSMIT CASCADED MODULES
    # ==================================================
    ./adf4351   $BB   25000000 $C &  # Base
    #sleep 0.001
    ./adf43512  $L1A 25000000 $C &
    #sleep 0.001
    ./adf43513  $L1B 25000000 $C &
    #sleep 0.001
    ./adf43514  $L2A 25000000 $C &
    #sleep 0.001
    ./adf43515  $L2B 25000000 $C &
    #sleep 0.001
    ./adf43516  $L2C 25000000 $C &
    #sleep 0.001
    ./adf43517  $L2D 25000000 $C &
    #sleep 0.001
    ./adf43518  $L3   25000000 $C      # Final collapsed beat
   # wait

    # ----------------------------
    # JITTERED DWELL
    # ----------------------------
    #sleep 0.00000$((RANDOM % 9 + 1))$((RANDOM % 9 + 1))
    echo "V2k"
done
