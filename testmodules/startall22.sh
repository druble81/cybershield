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

GROUPS = [
    MODULES[0:2],
    MODULES[2:4],
    MODULES[4:6],
    MODULES[6:8],
]

group_locked = [random.choice([True, False]) for _ in GROUPS]

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
O2 = 0.000004
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
# One independent range index per group
range_indices = [random.randrange(len(RANGES)) for _ in GROUPS]

# Controls how "random" things feel
LOCAL_DRIFT_PROB = 0.8   # small movement
MAX_DRIFT = 1            # ±1 index
JUMP_SIZE = 3            # occasional hop

bin_index = 0
SUB_BINS = 8
phase = 0

# ----------------------------
# COLLAPSE + GOLDEN RATIO STATE
# ----------------------------
collapse_group = 0
collapse_counter = 0
collapse_cycles = random.randint(LOCK_MIN, LOCK_MAX)

phi_index = 0  # golden-ratio walker


print("********** GOLDEN-RATIO HETERODYNE RUNNING **********")

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:

    # --- Range handling ---
    group_cmds = []
    bbs = []  # track BBs for logging

    for gi, mods in enumerate(GROUPS):

        # --- Small-random range evolution per group ---
        if random.random() < LOCAL_DRIFT_PROB:
            # gentle drift
            range_indices[gi] += random.choice([-MAX_DRIFT, 0, MAX_DRIFT])
        else:
            # occasional hop
            range_indices[gi] += random.randint(-JUMP_SIZE, JUMP_SIZE)

        range_indices[gi] %= len(RANGES)

        BASE, WIDTH = RANGES[range_indices[gi]]


        BIN_WIDTH = WIDTH / SUB_BINS
        BIN = (bin_index + phase + gi) % SUB_BINS
        BB = BASE + BIN * BIN_WIDTH + random.randint(0, int(BIN_WIDTH))
        bbs.append(BB)

        is_collapsed = (gi == collapse_group)

        if is_collapsed:
            # COLLAPSE: minimal motion, tight symmetry
            L1A = BB + O1
            L1B = BB - O1
        else:
            # FREE: jittered heterodyne
            L1A = BB + O1 + random.uniform(-JITTER, JITTER)
            L1B = BB - O1 + random.uniform(-JITTER, JITTER)

        for mod, freq in zip(mods, [L1A, L1B]):
            group_cmds.append((mod, freq))

            
    bin_index = (bin_index + 1) % SUB_BINS
    if bin_index == 0:
        phase = (phase + 1) % SUB_BINS
    # ----------------------------
    # COLLAPSE TIMING + GOLDEN RATIO ROTATION
    # ----------------------------
    collapse_counter += 1

    if collapse_counter >= collapse_cycles:
        collapse_counter = 0
        collapse_cycles = random.randint(LOCK_MIN, LOCK_MAX)

        # golden-ratio walk across groups
        phi_index = (phi_index + PHI) % len(GROUPS)
        collapse_group = int(phi_index)

   
    # ----------------------------
    # BUILD COMMANDS
    # ----------------------------
    procs = []
    for mod, freq in group_cmds:
        p = subprocess.Popen(
            [mod, f"{freq:.9f}", REFCLK, C],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
        procs.append(p)

    for p in procs:
        p.wait()


    state = "".join("C" if i == collapse_group else "-" for i in range(len(GROUPS)))

    print(
        f"[Groups {state}]  "
        f"Phase {phase}  "
        f"Bin {bin_index}"
    )


    time.sleep(random.uniform(0.2, 0.1))
