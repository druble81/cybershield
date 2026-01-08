
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




while :
do



echo "......................Full Coverage MODE......................"

sleep 1
done
