#!/usr/bin/env python3
import subprocess
import random
import time
import math

# ------------------------------------------------------------
# LOAD SG3 FREQUENCIES
# ------------------------------------------------------------
sg3_file = "/tmp/ramdisk/SG3.TXT"
with open(sg3_file, "r") as f:
    numbers = [int(x) for x in f.read().split() if x.isdigit()]

# ------------------------------------------------------------
# POWER LEVEL
# ------------------------------------------------------------
try:
    with open("/home/pi/Desktop/power.txt", "r") as f:
        C = f.read().strip()
except FileNotFoundError:
    C = "2"

# ------------------------------------------------------------
# ----- constants -------------------------------------------------
BASE_DELTA    = 0.003000      # not used for the new frequency list
FINAL_OFFSET  = 0.000002      # 10 Hz offset (as required)
DRIFT_AMPLITUDE = 0.000200    # ±200 Hz (still kept for compatibility)
DRIFT_SPEED     = 0.5

# ----- modules (9 entries) ---------------------------------------
MODULES = [
    "./adf4351", "./adf43512",
    "./adf43513", "./adf43514",
    "./adf43515", "./adf43516",
    "./adf43517", "./adf43518",
    "./adf43519",          # now 9 modules
]

# ----- main loop -------------------------------------------------
t = 0.0
while True:
    # pick 4 distinct bases (you may replace this with a range‑based selection)
    random_bases = random.sample(numbers, 4)

    direct_freqs = list(random_bases)                     # plain bases

    # offset frequencies – three bases get one offset, the last base gets two
    offset_freqs = [
        random_bases[0] + FINAL_OFFSET,
        random_bases[1] + FINAL_OFFSET,
        random_bases[2] + FINAL_OFFSET,
        random_bases[3] + FINAL_OFFSET,
        random_bases[3] + FINAL_OFFSET,   # second secondary for the last base
    ]

    freqs = []                                          # final list (9 entries)
    freqs.extend(direct_freqs)                          # modules 0‑3
    freqs.extend(offset_freqs)                          # modules 4‑8

    # launch processes
    procs = []
    for mod, freq in zip(MODULES, freqs):
        p = subprocess.Popen(
            [mod, f"{freq:.6f}", "25000000", str(C)],   # six decimals → 200.000010
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        procs.append(p)

    for p in procs:
        p.wait()

    # drift animation (unchanged)
    drift = DRIFT_AMPLITUDE * math.sin(t)
    delta_A = BASE_DELTA + drift
    delta_B = delta_A + FINAL_OFFSET   # kept only for compatibility

    t += DRIFT_SPEED
    time.sleep(0.001)
