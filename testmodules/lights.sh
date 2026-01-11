#!/bin/bash

# ============================================================
# CONFIG
# ============================================================
BASE_FREQ=3000
HZ=25000000
OFFSET=0
DELAY=0.15

# Module binary names
MODULES=(
  "./adf4351"
  "./adf43512"
  "./adf43513"
  "./adf43514"
  "./adf43515"
  "./adf43516"
  "./adf43517"
  "./adf43518"
  "./adf43519"
)

# ============================================================
# MODULE CONTROL
# ============================================================
module_on() {
    "$1" $BASE_FREQ $HZ $OFFSET >/dev/null 2>&1 &
}

module_off() {
    "$1" off >/dev/null 2>&1
}

all_on() {
    for m in "${MODULES[@]}"; do
        module_on "$m"
    done
}

all_off() {
    for m in "${MODULES[@]}"; do
        module_off "$m"
    done
}

# ============================================================
# PATTERNS
# ============================================================

chase() {
    all_off
    for m in "${MODULES[@]}"; do
        module_on "$m"
        sleep $DELAY
        module_off "$m"
    done
}

bounce() {
    all_off
    for m in "${MODULES[@]}"; do
        module_on "$m"
        sleep $DELAY
        module_off "$m"
    done
    for ((i=${#MODULES[@]}-2; i>0; i--)); do
        module_on "${MODULES[$i]}"
        sleep $DELAY
        module_off "${MODULES[$i]}"
    done
}

fill_up() {
    all_off
    for m in "${MODULES[@]}"; do
        module_on "$m"
        sleep $DELAY
    done
}

drain_down() {
    for ((i=${#MODULES[@]}-1; i>=0; i--)); do
        module_off "${MODULES[$i]}"
        sleep $DELAY
    done
}

pulse() {
    all_on
    sleep 0.4
    all_off
    sleep 0.4
}

alternating() {
    all_off
    for i in 0 2 4 6 8; do
        module_on "${MODULES[$i]}"
    done
    sleep 0.4
    all_off
    for i in 1 3 5 7; do
        module_on "${MODULES[$i]}"
    done
    sleep 0.4
    all_off
}

center_wave() {
    all_off
    pairs=(
        "4"
        "3 5"
        "2 6"
        "1 7"
        "0 8"
    )
    for p in "${pairs[@]}"; do
        for i in $p; do
            module_on "${MODULES[$i]}"
        done
        sleep $DELAY
    done
    sleep 0.3
    all_off
}

random_sparkle() {
    all_off
    for _ in {1..20}; do
        i=$((RANDOM % 9))
        module_on "${MODULES[$i]}"
        sleep 0.08
        module_off "${MODULES[$i]}"
    done
}

# ============================================================
# CLEAN EXIT
# ============================================================
trap all_off EXIT INT TERM

# ============================================================
# MAIN LOOP
# ============================================================
while true; do
    chase
    bounce
    fill_up
    drain_down
    pulse
    alternating
    center_wave
    random_sparkle
done
