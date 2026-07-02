#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess
import random
import time
import os

# ----------------------------------------------------------------------
# USER TUNABLES
# ----------------------------------------------------------------------
TARGET_HZ   = 1          # final carrier frequency (once we hit it we stay here)
START_HZ    = 12         # start value for the ramp‑down
STEP_HZ     = 1          # how many Hz to step down each loop

DWELL_BASE  = 4          # dwell time while we are still ramping down (seconds)
DWELL_VAR   = 9          # jitter on the dwell time while ramping (seconds)

# ----------------------------------------------------------------------
# FILES THAT THE ORIGINAL SCRIPT READS – they are kept because the
# modules probably expect the values they contain.
# ----------------------------------------------------------------------
POWER_FILE = "/home/pi/Desktop/power.txt"
SG3_FILE   = "/tmp/ramdisk/SG3.TXT"

# ----------------------------------------------------------------------
# NOT USED ANYMORE (kept only for completeness)
# ----------------------------------------------------------------------
PHI = 0.6180339887498949      # golden ratio – not used in the new logic
TOTAL_MODULES = 9            # we have nine modules in the list below

# ----------------------------------------------------------------------
# READ POWER SETTING (the value that is passed to every module)
# ----------------------------------------------------------------------
if os.path.exists(POWER_FILE):
    with open(POWER_FILE, "r") as f:
        C = f.read().strip()
else:
    C = "2"
print(f"Power: {C}")

# ----------------------------------------------------------------------
# READ SG3 RANGE – this is only used to pick a random “base carrier”
# ----------------------------------------------------------------------
try:
    with open(SG3_FILE, "r") as f:
        lines = [int(x) for x in f.read().split() if x.isdigit()]
        MIN_BB = 80
        MAX_BB = 280
except Exception as e:
    print(f"[Error] SG3 missing, using defaults: {e}")
    MIN_BB, MAX_BB = 80, 150

print(f"SG3 Range (BB): {MIN_BB} – {MAX_BB}")

# ----------------------------------------------------------------------
# MODULE LIST – must stay in the same order as the frequencies we will
# hand to them.  There are nine entries → 4 + 5 split.
# ----------------------------------------------------------------------
MODULES = [
    "./adf43513",
    "./adf43514",
    "./adf43515",
    "./adf43516",
    "./adf43517",
    "./adf43518",   # centre of the list – not used for lock any more
    "./adf4351",
    "./adf43512",
    "./adf43519"
]

# ----------------------------------------------------------------------
# HELPER: launch all modules and wait until they finish
# ----------------------------------------------------------------------
def run_modules(assignments):
    """Start every module with its frequency string and wait for them."""
    procs = []
    for mod, freq in assignments:
        # each module expects: <executable> <frequency> <refclk> <power‑setting>
        p = subprocess.Popen([mod, freq, str(25_000_000), C])
        procs.append(p)
    for p in procs:
        p.wait()

# ----------------------------------------------------------------------
# MAIN LOOP
# ----------------------------------------------------------------------
current_hz = START_HZ                     # we start at 12 Hz

while True:
    # --------------------------------------------------------------
    # 1️⃣  RAMP‑DOWN – decrease the carrier until we hit TARGET_HZ
    # --------------------------------------------------------------
    if current_hz > TARGET_HZ:
        current_hz -= STEP_HZ               # step down one Hz per iteration

    # --------------------------------------------------------------
    # 2️⃣  PICK A BASE CARRIER (random within the SG3 range)
    # --------------------------------------------------------------
    BB = random.randint(MIN_BB, MAX_BB)   # e.g. 80 … 280 kHz

    assignments = []                       # (module_path, frequency_string)

    # --------------------------------------------------------------
    # 3️⃣  ASSIGN FREQUENCIES
    #     – first 4 modules get ONLY the base carrier (no hz addition)
    #     – the remaining 5 modules get BASE + CURRENT_HZ
    # --------------------------------------------------------------
    for i in range(4):                       # indices 0‑3 → 4 modules
        suffix = (i * 100_000) % 1_000_000   # a deterministic 6‑digit suffix
        freq_str = f"{BB}.{suffix:06d}"
        assignments.append((MODULES[i], freq_str))

    for i in range(4, len(MODULES)):          # indices 4‑8 → 5 modules
        suffix = ((i - 4 + 1) * 100_000) % 1_000_000
        freq_str = f"{BB + current_hz}.{suffix:06d}"
        assignments.append((MODULES[i], freq_str))

    # --------------------------------------------------------------
    # 4️⃣  LAUNCH THE MODULES WITH THE FREQUENCIES WE JUST BUILT
    # --------------------------------------------------------------
    run_modules(assignments)

    # --------------------------------------------------------------
    # 5️⃣  Dwell time
    #     – while we are still ramping down → longer sleep with jitter
    #     – once we have reached 1 Hz → change every 1‑2 seconds
    # --------------------------------------------------------------
    if current_hz > TARGET_HZ:
        dwell = DWELL_BASE + random.uniform(0, DWELL_VAR)   # 4 … 13 s
    else:
        dwell = 1.0 + random.uniform(0, 1.0)                # 1.0 … 2.0 s

    time.sleep(dwell)
