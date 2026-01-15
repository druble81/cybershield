#!/usr/bin/env python3
import subprocess
import random
import time
from collections import deque

# ----------------------------
# CONSTANTS
# ----------------------------
PHI = 0.6180339887498949
TOTAL_MODULES = 8
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
]

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
O1 = 0.000003
O2 = 0.010000
O3 = 0.000005
JITTER = 0.000001

# ----------------------------
# RANGES
# ----------------------------
RANGES = [
    (495, 10), (4200, 200), (85, 55), (4200, 190),
    (950, 100), (1500, 200), (3000, 200), (3400, 200),
    (3800, 200), (4000, 195), (4200, 200), (85, 35)
]

# ----------------------------
# LOCK-COLLAPSE CONTROL
# ----------------------------
LOCK_MIN = 5
LOCK_MAX = 15
lock_cycles = random.randint(LOCK_MIN, LOCK_MAX)
lock_counter = 0
LOCK_MODULE_INDEX = 7  # adf43518

# ----------------------------
# RANGE SHUFFLE
# ----------------------------
random.shuffle(RANGES)
range_index = 0
bin_index = 0
SUB_BINS = 8
phase = 0

print("********** GOLDEN-RATIO HETERODYNE RUNNING **********")

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:

    # --- Range handling ---
    BASE, WIDTH = RANGES[range_index]
    range_index = (range_index + 1) % len(RANGES)
    if range_index == 0:
        random.shuffle(RANGES)
        phase = (phase + 1) % SUB_BINS

    BIN_WIDTH = WIDTH / SUB_BINS
    BIN = (bin_index + phase) % SUB_BINS
    BB = BASE + BIN * BIN_WIDTH + random.randint(0, int(BIN_WIDTH))
    bin_index = (bin_index + 1) % SUB_BINS

    # --- Heterodyne layers ---
    L1A = BB + O1 + random.uniform(-JITTER, JITTER)
    L1B = BB - O1 + random.uniform(-JITTER, JITTER)

    L2A = L1A + O2
    L2B = L1A - O2
    L2C = L1B + O2
    L2D = L1B - O2

    L3 = (L2A + L2B + L2C + L2D) / 4 + random.uniform(-JITTER, JITTER)

    # ----------------------------
    # ROLE LIST (frequency roles)
    # ----------------------------
    roles = deque([
        BB,
        L1A,
        L1B,
        L2A,
        L2B,
        L2C,
        L2D,
        L3,   # collapse
    ])

    # ----------------------------
    # LOCK-COLLAPSE LOGIC
    # ----------------------------
    lock_counter += 1
    locked = lock_counter <= lock_cycles

    if locked:
        roles.remove(L3)

    # ----------------------------
    # GOLDEN-RATIO ROTATION
    # ----------------------------
    step = max(1, int(len(roles) * PHI))
    roles.rotate(step)

    if locked:
        roles.insert(LOCK_MODULE_INDEX, L3)
    else:
        lock_counter = 0
        lock_cycles = random.randint(LOCK_MIN, LOCK_MAX)

    # ----------------------------
    # BUILD COMMANDS
    # ----------------------------
    cmds = []
    for mod, freq in zip(MODULES, roles):
        cmds.append((mod, freq))

    # ----------------------------
    # EXECUTE MODULES
    # ----------------------------
    procs = []
    for mod, freq in cmds:
        p = subprocess.Popen(
            [mod, f"{freq:.9f}", REFCLK, C],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
        procs.append(p)

    for p in procs:
        p.wait()

    print(
        f"[BB {BB:.3f}]  "
        f"Collapse {'LOCKED' if locked else 'FREE'}  "
        f"Lock {lock_counter}/{lock_cycles}"
    )

    time.sleep(random.uniform(0.05, 0.000001))
