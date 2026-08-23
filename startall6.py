#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess
import random
import time
import os
import sys

# ----------------------------------------------------------------------
# TOTAL number of modules you will start (the list below has 8 entries)
# ----------------------------------------------------------------------
TOTAL_MODULES = 9
PHI = 0.6180339887498949          # golden ratio – kept for possible future use

# ----------------------------------------------------------------------
# LOCK‑COLLAPSE TUNABLES (unchanged)
# ----------------------------------------------------------------------
LOCK_COLLAPSE_PROB = 0.5          # 50 % chance each loop to start a collapse window
LOCK_COLLAPSE_MIN  = 1            # minimum number of loops the collapse stays active
LOCK_COLLAPSE_MAX  = 5            # maximum number of loops the collapse stays active
lock_collapse_active = 0          # counter – 0 means “not collapsed”

MIN_DWELL = 0.01                  # smallest sleep while we are still ramping
MAX_DWELL = 0.03                  # biggest sleep while we are still ramping

# ----------------------------------------------------------------------
# READ POWER (the value that is passed to every module)
# ----------------------------------------------------------------------
power_file = "/home/pi/Desktop/power.txt"
if os.path.exists(power_file):
    with open(power_file, "r") as f:
        C = f.read().strip()
else:
    C = "2"
print(f"C is set to: {C}")

# ----------------------------------------------------------------------
# READ SG3 BASE FREQUENCIES (used only for the BB offset)
# ----------------------------------------------------------------------
sg3_file = "/tmp/ramdisk/SG3.TXT"
try:
    with open(sg3_file, "r") as f:
        numbers = [int(x) for x in f.read().split() if x.isdigit()]
except FileNotFoundError:
    print(f"[Error] Could not read {sg3_file}")
    sys.exit(1)

if not numbers:
    print("[Error] No numbers found in", sg3_file)
    sys.exit(1)

MIN_BB = numbers[0]
MAX_BB = numbers[-1]

# (the original script overwrote these with fixed values – we keep the fixed ones)
MIN_BB = 300
MAX_BB = 400

# ----------------------------------------------------------------------
# DETERMINE THE TARGET HZ (the value we want to reach)
# ----------------------------------------------------------------------
if len(sys.argv) > 1:                     # explicit command‑line argument
    try:
        gethz = int(sys.argv[1])
        menu_used = False
    except ValueError:
        print("[Warning] Invalid argument – falling back to menu")
        gethz = 0
        menu_used = True
else:                                      # no argument → ask the helper script
    try:
        gethz_str = subprocess.check_output(
            ["python3", "/home/pi/Desktop/selecthz.py"], text=True
        ).strip()
        gethz = int(gethz_str)
        menu_used = True
    except Exception as e:
        print(f"[Error] Could not obtain Hz from selecthz.py: {e}")
        gethz = 0
        menu_used = True

print(f"[Wake] Using gethz = {gethz} | menu_used = {menu_used}")

# ----------------------------------------------------------------------
# SET‑UP FOR THE RAMP‑UP LOGIC
# ----------------------------------------------------------------------
target_hz = max(1, gethz) if gethz > 0 else None   # None → no ramp‑up (pure cascade)
effective_hz = 1                                   # we start at 1 Hz

# ----------------------------------------------------------------------
# OFFSETS / HZ VALUES
# ----------------------------------------------------------------------
OFFSET_MIN = 100_000
OFFSET_MAX = 999_400
hz_values = [10, 11, 15, 19]                       # not used directly – kept for compatibility
offset = 500000
# ----------------------------------------------------------------------
# BIDIRECTIONAL VARIABLES (kept because the original cascade code uses them)
# ----------------------------------------------------------------------
direction = 1
BIDIR_MIN = 18
BIDIR_MAX = 25
hz1 = hz_values[0]                                 # will be overwritten later

# ----------------------------------------------------------------------
# HELPER – start all modules and wait for them to finish
# ----------------------------------------------------------------------
def run_modules(module_cmds):
    """Launch the given list of (command, frequency) tuples."""
    procs = []
    for cmd, freq in module_cmds:
        p = subprocess.Popen([cmd, freq, "25000000", C])
        procs.append(p)
    for p in procs:
        p.wait()

# ----------------------------------------------------------------------
# MAIN LOOP
# ----------------------------------------------------------------------
while True:

    # --------------------------------------------------------------
    # 1️⃣  RAMP‑UP (only when a target Hz is defined)
    # --------------------------------------------------------------
    if target_hz is not None and effective_hz < target_hz:
        effective_hz += 1                     # step up by one Hertz each iteration

    # --------------------------------------------------------------
    # 2️⃣  PICK A BASE CARRIER (random within the SG3 range)
    # --------------------------------------------------------------
    BB = random.randint(150, 245)            # base carrier frequency (kHz)

    # --------------------------------------------------------------
    # 3️⃣  LOCK‑COLLAPSE STATE MACHINE (unchanged)
    # --------------------------------------------------------------
    collapse_mode = False
    if lock_collapse_active == 0 and random.random() < LOCK_COLLAPSE_PROB:
        lock_collapse_active = random.randint(LOCK_COLLAPSE_MIN, LOCK_COLLAPSE_MAX)
        print("[LOCK COLLAPSE ENGAGED]")

    collapse_mode = lock_collapse_active > 0
    if collapse_mode:
        lock_collapse_active -= 1
        if lock_collapse_active == 0:
            print("[LOCK COLLAPSE RELEASED]")

    # --------------------------------------------------------------
    # 4️⃣  DETERMINE THE HZ VALUES THAT WILL BE USED FOR THE FREQUENCIES
    # --------------------------------------------------------------
    if gethz == 0:                     # ------- CASCADE / BIDIRECTIONAL MODE -------
        if collapse_mode:
            # all four Hz values become a single random value while collapsed
            hz1 = hz2 = hz3 = hz4 = random.randint(BIDIR_MIN, BIDIR_MAX)
            offset_base = offset
        else:
            # normal cascade behaviour (unchanged from the original script)
            if hz1 >= BIDIR_MAX:
                direction = -1
            elif hz1 <= BIDIR_MIN:
                direction = 1
            hz1 += direction
            hz2 = hz1
            hz3 = hz1
            hz4 = hz1
            offset_base = offset
            MIN_DWELL = 0.01
            MAX_DWELL = 0.03

    else:                               # ------- MANUAL MODE (ramp‑up) -------
        # initialise the “manual” counter only once
        if 'manual_hz' not in globals():
            manual_hz = 1                # start at 1 Hz
        if manual_hz < target_hz:
            manual_hz += 1               # keep climbing until we hit the target
        hz1 = hz2 = hz3 = hz4 = manual_hz   # all four Hz entries are now equal
        offset_base = offset

    # --------------------------------------------------------------
    # 5️⃣  BUILD THE FREQUENCY COMBINATIONS (8 modules → 8 combos)
    # --------------------------------------------------------------
    freq_combos = [
        f"{BB}.{offset_base:06d}",                     # base only
        f"{BB}.{offset_base + hz1:06d}",
        f"{BB}.{offset_base + hz2:06d}",
        f"{BB}.{offset_base + hz3:06d}",
        f"{BB}.{offset_base + hz4:06d}",
        f"{BB}.{offset_base:06d}",                     # duplicate base entries – kept as‑is
        f"{BB}.{offset_base:06d}",
        f"{BB}.{offset_base:06d}",
        f"{BB}.{offset_base:06d}",
    ]

    # a tiny golden‑ratio rotation (does not affect the logic)
    freq_combos = freq_combos[1:] + freq_combos[:1]

    module_cmds = [
        ("/home/pi/Desktop/adf4351",      freq_combos[0]),
        ("/home/pi/Desktop/adf43512",     freq_combos[1]),
        ("/home/pi/Desktop/adf43513",     freq_combos[2]),
        ("/home/pi/Desktop/adf43514",     freq_combos[3]),
        ("/home/pi/Desktop/adf43515",     freq_combos[4]),
        ("/home/pi/Desktop/adf43516",     freq_combos[5]),
        ("/home/pi/Desktop/adf43517",     freq_combos[6]),
        ("/home/pi/Desktop/adf43518",     freq_combos[7]),
        ("/home/pi/Desktop/adf43519",     freq_combos[7]),
    ]

    # --------------------------------------------------------------
    # 6️⃣  LAUNCH THE MODULES
    # --------------------------------------------------------------
    run_modules(module_cmds)

    # --------------------------------------------------------------
    # 7️⃣  DEBUG / STATUS OUTPUT
    # --------------------------------------------------------------
    if collapse_mode:
        print(f"[COLLAPSE] BB={BB} | hz={hz1}")
    elif gethz == 0:
        print(f"[Cascade] BB={BB} | hz1={hz1}")
    else:
        print(f"[Normal] BB={BB} | hz1={hz1}")

    # --------------------------------------------------------------
    # 8️⃣  Dwell time
    # --------------------------------------------------------------
    if gethz == 0:                     # cascade mode – short jittered sleeps
        dwell = random.uniform(MAX_DWELL, MIN_DWELL)   # original behaviour (min‑max swapped)
    else:
        # once we have reached the target Hz we use a longer sleep window
        if manual_hz >= target_hz:
            dwell = random.uniform(30, 60)          # 30 – 60 s after the ramp is finished
        else:
            dwell = random.uniform(0.01, 0.03)       # small jitter while still ramping

    time.sleep(dwell)
