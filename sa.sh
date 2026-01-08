#!/bin/bash

########################################
# LOAD VALUES
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

T3=$((T1*2))
T4=$((T2*2))

cd /tmp/ramdisk || exit 1

########################################
# POWER
########################################

FILE="/home/pi/Desktop/power.txt"
if [[ -f "$FILE" ]]; then
    C=$(<"$FILE")
else
    C=2
fi

########################################
# STATE TRACKING (NO RESTARTS)
########################################

declare -A RUNNING_PID

start_if_not_running() {
    local key="$1"
    local cmd="$2"

    if [[ -n "${RUNNING_PID[$key]}" ]] && kill -0 "${RUNNING_PID[$key]}" 2>/dev/null; then
        return
    fi

    eval "$cmd &"
    RUNNING_PID[$key]=$!
}

########################################
# START ALL MODULES ONCE
########################################

echo ">>> STARTING BURST MODE (PERSISTENT)"

# Anchor / primary (module 13)
start_if_not_running 13 "/tmp/ramdisk/adf43513 1000 25000000 $C $T3 $T4 1"

# Remaining modules
start_if_not_running 1  "/tmp/ramdisk/adf4351  1000 25000000 $C $T1 $T2"
start_if_not_running 12 "/tmp/ramdisk/adf43512 1000 25000000 $C $T1 $T2"
start_if_not_running 14 "/tmp/ramdisk/adf43514 1000 25000000 $C $T1 $T2"
start_if_not_running 15 "/tmp/ramdisk/adf43515 1000 25000000 $C $T1 $T2"
start_if_not_running 16 "/tmp/ramdisk/adf43516 1000 25000000 $C $T1 $T2"
start_if_not_running 17 "/tmp/ramdisk/adf43517 1000 25000000 $C $T1 $T2"
start_if_not_running 18 "/tmp/ramdisk/adf43518 1000 25000000 $C $T1 $T2"
start_if_not_running 19 "/tmp/ramdisk/adf43519 1000 25000000 $C $T1 $T2"

########################################
# MAIN LOOP (STATUS ONLY)
########################################

while true; do
    echo "===== BURST MODE ACTIVE ====="

    sleep 4
done
