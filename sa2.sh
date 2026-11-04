
#!/bin/bash

########################################
# LOAD POWER & TIMING VALUES
########################################

FILE="/home/pi/Desktop/nvalues.txt"
DEFAULT_T1=140
DEFAULT_T2=65

if [[ -f "$FILE" ]]; then
    read T1 T2 < "$FILE"
else
    T1=$DEFAULT_T1
    T2=$DEFAULT_T2
fi

T3=$((T1*5))
T4=$((T2*4))

# Power
FILE="/home/pi/Desktop/power.txt"
if [[ -f "$FILE" ]]; then
    C=$(<"$FILE")
else
    C=2
fi

cd /tmp/ramdisk || exit 1

########################################
# START MODULES
########################################

# Module 3 (controller with full cascade)
/tmp/ramdisk/adf43513 3000 25000000 $C $T3 $T4 2 &

echo "Module 3 started with full cascade control"

# Slave modules (1–2, 4–12 in your numbering)
# Manually start them once; no restart logic needed
/tmp/ramdisk/adf4351 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43512 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43514 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43515 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43516 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43517 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43518 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43519 3000 25000000 $C $T1 $T2 &

echo "Slave modules started, now waiting for Module 3 control"

# End script — no looping, no restarts


echo "Module 3 started with full cascade control"


sudo pkill -f "adf4351[0-9]*"
sleep 0.1

# Module 3 (controller with full cascade)
/tmp/ramdisk/adf43513 3000 25000000 $C $T3 $T4 2 &


# Slave modules (1–2, 4–12 in your numbering)
# Manually start them once; no restart logic needed
/tmp/ramdisk/adf4351 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43512 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43514 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43515 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43516 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43517 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43518 3000 25000000 $C $T1 $T2 &
/tmp/ramdisk/adf43519 3000 25000000 $C $T1 $T2 &


FILE="/tmp/ramdisk/SG3.TXT"



SG1=$(grep -oE '[0-9]+([.][0-9]+)?' "$FILE" | head -n 1)
SG2=$(grep -oE '[0-9]+([.][0-9]+)?' "$FILE" | tail -n 1)

echo "SG1=$SG1"
echo "SG2=$SG2"
ITER=0
ITER2=0


while :
do

 ITER=$((ITER + 1))
    ITER2=$((ITER + 1))
    
# Every 8 iterations, trigger loadrd
if (( ITER % 8 == 0 )); then

    SG_COUNT=$((SG2 - SG1 + 1))

    # Do not trigger loadrd if range contains fewer than 10 values
    if (( SG_COUNT >= 10 )); the5
        if (( SG_COUNT < 400 )); then
            # Small ranges: minimum 30%, maximum 50%
            MIN_PARAM=1
            MAX_PARAM=6
        else
            # Larger ranges: minimum 25%, maximum 50
            MIN_PARAM=2
            MAX_PARAM=8
        fi

        # Ensure valid random range
        (( MIN_PARAM < 1 )) && MIN_PARAM=1

        RAND_PARAM=$(( (RANDOM % (MAX_PARAM - MIN_PARAM + 1)) + MIN_PARAM ))

        echo ">>> [ITERATION $ITER] Triggering loadrd: SG1=$SG1 SG2=$SG2 RAND_PARAM=$RAND_PARAM"

        sudo /home/pi/Desktop/loadrd "$SG1" "$SG2" "$RAND_PARAM" &
    else
        echo ">>> [ITERATION $ITER] Skipping loadrd: SG range count ($SG_COUNT) is below 10"
    fi
fi


echo "......................Full Coverage MODE......................"

sleep 1
done
