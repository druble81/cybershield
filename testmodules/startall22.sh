#!/usr/bin/env python3
import subprocess
import random
import time

# ----------------------------
# POWER LEVEL
# ----------------------------
try:
    with open("/home/pi/Desktop/power.txt", "r") as f:
        C = f.read().strip()
except FileNotFoundError:
    C = "2"

# ----------------------------
# HETERODYNE OFFSETS (MHz)
# ----------------------------
O1 = 0.000003      # Layer 1 ± offset (3 Hz)
O2 = 0.010000      # Layer 2 ± offset (10 kHz)
O3 = 0.000005      # Layer 3 collapse ± offset (5 Hz)
JITTER = 0.000001  # optional ±1 Hz micro jitter

# ----------------------------
# RANGE DEFINITIONS
# ----------------------------
RANGES = [
    (495, 10),
    (4200, 200),
    (85, 55),
    (4200, 190),
    (950, 100),
    (1500, 200),
    (3000, 200),
    (3400, 200),
    (3800, 200),
    (4000, 195),
    (4400, 4200),
    (85, 35)
]

# ----------------------------
# SUB-BINS / PHASE ROTATION
# ----------------------------
SUB_BINS = 8
bin_index = 0
phase = 0

def shuffle_ranges(ranges):
    shuffled = ranges.copy()
    random.shuffle(shuffled)
    return shuffled

shuffled_ranges = shuffle_ranges(RANGES)
range_index = 0

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:
    BASE, WIDTH = shuffled_ranges[range_index]
    range_index += 1
    if range_index >= len(shuffled_ranges):
        range_index = 0
        shuffled_ranges = shuffle_ranges(RANGES)
        phase = (phase + 1) % SUB_BINS

    BIN_WIDTH = WIDTH / SUB_BINS
    BIN = (bin_index + phase) % SUB_BINS
    BB = BASE + BIN * BIN_WIDTH + random.randint(0, int(BIN_WIDTH))
    bin_index = (bin_index + 1) % SUB_BINS

    # ----------------------------
    # LAYER 1
    # ----------------------------
    L1A = BB + O1 + random.uniform(-JITTER, JITTER)
    L1B = BB - O1 + random.uniform(-JITTER, JITTER)

    # ----------------------------
    # LAYER 2
    # ----------------------------
    L2A = L1A + O2
    L2B = L1A - O2
    L2C = L1B + O2
    L2D = L1B - O2

    # ----------------------------
    # LAYER 3 COLLAPSE
    # ----------------------------
    L3 = (L2A + L2B + L2C + L2D)/4 + random.uniform(-JITTER, JITTER)

    # ----------------------------
    # TRANSMIT MODULES
    # ----------------------------
    cmds = [
        ("./adf4351", BB),
        ("./adf43512", L1A),
        ("./adf43513", L1B),
        ("./adf43514", L2A),
        ("./adf43515", L2B),
        ("./adf43516", L2C),
        ("./adf43517", L2D),
        ("./adf43518", L3)
    ]

    procs = []
    for cmd, freq in cmds:
        p = subprocess.Popen([cmd, f"{freq:.9f}", "25000000", str(C)])
        procs.append(p)
        #time.sleep(0.001)  # tiny spacing between module calls

    for p in procs:
        p.wait()

    # ----------------------------
    # OPTIONAL DWELL
    # ----------------------------
    dwell = random.uniform(0.000001, 0.000009)
    time.sleep(dwell)

    print("V2k")
