#!/usr/bin/env python3
import subprocess
import random
import time
import math

# ------------------------------------------------------------
# CONSTANTS
# ------------------------------------------------------------
PHI = 0.6180339887498949   # not used, but keep if needed
REFCLK = "25000000"

MODULES = [
    "./adf4351",
    "./adf43512",
    "./adf43513",
    "./adf43514",
    "./adf43515",
    "./adf43516",
    "./adf43517",
    "./adf43518",
    "./adf43519",   # added missing module, total 9
]

# Power level (kept for compatibility)
try:
    with open("/home/pi/Desktop/power.txt", "r") as f:
        C = f.read().strip()
except FileNotFoundError:
    C = "2"

# Drift settings (kept but not used in frequency assignment)
BASE_DELTA = 0.003000      # 3000 Hz
FINAL_OFFSET = 0.000010    # 10 Hz offset (as requested)

DRIFT_AMPLITUDE = 0.000200  # ±200 Hz
DRIFT_SPEED = 0.5          # slower = smoother

# Ranges from which primaries are drawn
RANGES = [
    (495, 10), (4200, 200), (85, 55), (4200, 190),
    (950, 100), (1500, 200), (3000, 200), (3400, 200),
    (3800, 200), (4000, 195), (4200, 200), (85, 35), (5700, 200),
    (6000, 200), (5000, 200), (4600, 200)
]

# ------------------------------------------------------------
# MAIN LOOP
# ------------------------------------------------------------
t = 0.0
while True:
    # ---- pick 4 distinct modules for primaries (first four) ----
    primary_indices = [0, 1, 2, 3]          # modules 0‑3 will be primaries

    primary_freqs = []
    for idx in primary_indices:
        rng = random.choice(RANGES)
        low, high = rng
        freq = random.uniform(low, high)   # pick a frequency inside the range
        primary_freqs.append(freq)

    # ---- build full frequency list for all 9 modules ----
    freqs = [0.0] * len(MODULES)            # placeholder

    # assign primaries to modules 0‑3
    for i, mod in enumerate(primary_indices):
        freqs[i] = primary_freqs[i]

    # assign secondary frequencies (base + offset)
    # modules 4‑6 get secondaries of the first three primaries
    freqs[4] = primary_freqs[0] + FINAL_OFFSET   # secondary of primary0
    freqs[5] = primary_freqs[1] + FINAL_OFFSET   # secondary of primary1
    freqs[6] = primary_freqs[2] + FINAL_OFFSET   # secondary of primary2

    # the last primary (module3) gets two secondaries → modules 7 and 8
    sec_last = primary_freqs[3] + FINAL_OFFSET
    freqs[7] = sec_last      # first secondary for the last module
    freqs[8] = sec_last      # second secondary for the last module (same value)

    # ---- launch processes ----
    procs = []
    for mod, freq in zip(MODULES, freqs):
        p = subprocess.Popen(
            [mod, f"{freq:.9f}", REFCLK, C],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        procs.append(p)

    # wait for all to finish before next iteration
    for p in procs:
        p.wait()

    # small pause (no jitter/golden‑ratio logic)
    time.sleep(0.01)
