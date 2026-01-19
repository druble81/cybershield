#!/usr/bin/env python3
import subprocess
import random
import time
import os
import sys

TOTAL_MODULES = 8
PHI = 0.6180339887498949

# ----------------------------
# LOCK COLLAPSE TUNABLES
# ----------------------------
LOCK_COLLAPSE_PROB = 0.5     # 6% chance per loop
LOCK_COLLAPSE_MIN  = 1        # min cycles collapsed
LOCK_COLLAPSE_MAX  = 5       # max cycles collapsed

lock_collapse_active = 0

MIN_DWELL = 0.05
MAX_DWELL = 0.3

# ----------------------------
# READ POWER
# ----------------------------
power_file = "/home/pi/Desktop/power.txt"
if os.path.exists(power_file):
    with open(power_file, "r") as f:
        C = f.read().strip()
else:
    C = "2"

print(f"C is set to: {C}")

# ----------------------------
# READ SG3 BASE FREQUENCIES
# ----------------------------
sg3_file = "/tmp/ramdisk/SG3.TXT"
try:
    with open(sg3_file, "r") as f:
        numbers = [int(x) for x in f.read().split() if x.isdigit()]
except FileNotFoundError:
    print(f"No numbers found: {sg3_file}")
    exit(1)

if not numbers:
    print(f"No numbers found in {sg3_file}")
    exit(1)

MIN_BB = numbers[0]
MAX_BB = numbers[-1]


MIN_BB = 75
MAX_BB = 245


# ----------------------------
# DETERMINE gethz
# ----------------------------
if len(sys.argv) > 1:
    # Explicit argument passed on command line
    gethz = int(sys.argv[1])
    menu_used = False
else:
    # No argument → use menu
    try:
        gethz_str = subprocess.check_output(
            ["python3", "/home/pi/Desktop/selecthz.py"], text=True
        ).strip()
        gethz = int(gethz_str)
        menu_used = True
    except Exception as e:
        print(f"[Error] Could not get Hz from selecthz.py: {e}")
        gethz = 0
        menu_used = True

print(f"[Wake] Using gethz = {gethz} | menu_used = {menu_used}")


# ----------------------------
# OFFSETS / HZ VALUES
# ----------------------------
OFFSET_MIN = 100_000
OFFSET_MAX = 999_400
hz_values = [10, 11, 15, 19]

# ----------------------------
# BIDIRECTIONAL VARIABLES
# ----------------------------
direction = 1
BIDIR_MIN = 18
BIDIR_MAX = 25
hz1 = hz_values[0]

# ----------------------------
# HELPER
# ----------------------------
def run_modules(module_cmds):
    procs = []
    for cmd, freq in module_cmds:
        p = subprocess.Popen([cmd, freq, "25000000", C])
        procs.append(p)
    for p in procs:
        p.wait()

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:

    # --- Determine BB ---
    BB = random.randint(150, 245)
    offset = random.randint(OFFSET_MIN, OFFSET_MAX)

    # ----------------------------
    # LOCK COLLAPSE STATE MACHINE (for all modes)
    # ----------------------------
    collapse_mode = False
    if lock_collapse_active == 0 and random.random() < LOCK_COLLAPSE_PROB:
        lock_collapse_active = random.randint(
            LOCK_COLLAPSE_MIN, LOCK_COLLAPSE_MAX
        )
        print("[LOCK COLLAPSE ENGAGED]")

    collapse_mode = lock_collapse_active > 0
    if collapse_mode:
        lock_collapse_active -= 1
        if lock_collapse_active == 0:
            print("[LOCK COLLAPSE RELEASED]")

    # ----------------------------
    # Determine Hz assignments
    # ----------------------------
    if gethz == 0:
        # CASCADE / BIDIRECTIONAL MODE
        if lock_collapse_active > 0:
            # LOCK COLLAPSE: collapse all layers to the same random value
            hz1 = hz2 = hz3 = hz4 = random.randint(BIDIR_MIN, BIDIR_MAX)
            offset_base = offset
        else:
            # Normal cascade increment
            if hz1 >= BIDIR_MAX:
                direction = -1
            elif hz1 <= BIDIR_MIN:
                direction = 1
            hz1 += direction
            hz2 = hz1
            hz3 = hz1
            hz4 = hz1
            offset_base = offset
            MIN_DWELL = 0.5
            MAX_DWELL = 5
            
    else:
        # MANUAL MODE: fixed Hz, no cascade, no lock collapse changes
        if 'manual_hz' not in globals():
            manual_hz = hz_values[0]  # start at base (10 Hz)
        # increment up to requested gethz
        if manual_hz < gethz:
            manual_hz += 1
        if manual_hz == gethz:
            MIN_DWELL = 0.5
            MAX_DWELL = 5
        hz1 = hz2 = hz3 = hz4 = manual_hz
        offset_base = offset




    # ----------------------------
    # Create frequency combinations
    # ----------------------------
    freq_combos = [
        f"{BB}.{offset_base:06d}",
        f"{BB}.{offset_base + hz1:06d}",
        f"{BB}.{offset_base + hz2:06d}",
        f"{BB}.{offset_base + hz3:06d}",
        f"{BB}.{offset_base + hz4:06d}",
        f"{BB}.{offset_base:06d}",
        f"{BB}.{offset_base:06d}",
        f"{BB}.{offset_base:06d}",
    ]

    # ----------------------------
    # Rotate assignments for GOLDEN-RATIO style
    # ----------------------------
    # minimal rotation without affecting other logic
    freq_combos = freq_combos[1:] + freq_combos[:1]

    module_cmds = [
        ("./adf4351",  freq_combos[0]),
        ("./adf43512", freq_combos[1]),
        ("./adf43513", freq_combos[2]),
        ("./adf43514", freq_combos[3]),
        ("./adf43515", freq_combos[4]),
        ("./adf43516", freq_combos[5]),
        ("./adf43517", freq_combos[6]),
        ("./adf43518", freq_combos[7]),
    ]

    run_modules(module_cmds)

    # ----------------------------
    # Debug
    # ----------------------------
    if collapse_mode:
        print(f"[COLLAPSE] BB={BB} | hz={hz1}")
    elif gethz == 0:
        print(f"[Cascade] BB={BB} | hz1={hz1}")
    else:
        print(f"[Normal] BB={BB} | hz1={hz1}")

    # ----------------------------
    # Micro jitter dwell
    # ----------------------------
    time.sleep(random.uniform(MAX_DWELL, MIN_DWELL))
