#!/usr/bin/env python3
import subprocess
import random
import time

# ----------------------------
# READ SG3 BASE FREQUENCIES
# ----------------------------
sg3_file = "/tmp/ramdisk/SG3.TXT"
try:
    with open(sg3_file, "r") as f:
        numbers = [int(x) for x in f.read().split() if x.isdigit()]
except FileNotFoundError:
    print(f"No file found: {sg3_file}")
    exit(1)

if not numbers:
    print(f"No numbers found in {sg3_file}")
    exit(1)

MIN_BB = numbers[0]
MAX_BB = numbers[-1]

# ----------------------------
# POWER LEVEL
# ----------------------------
try:
    with open("/home/pi/Desktop/power.txt", "r") as f:
        C = f.read().strip()
except FileNotFoundError:
    C = "2"

# ----------------------------
# LAYERED HETERODYNE OFFSETS (MHz)
# ----------------------------
O1 = 0.000003   # Layer 1 ± offset = 3 Hz
O2 = 0.010000   # Layer 2 ± offset = 10 kHz
O3 = 0.000003   # Layer 3 ± offset = 3 Hz
JITTER = 0.000001  # optional micro jitter ±1 Hz

# ----------------------------
# GROUP CONTROL
# ----------------------------
GROUP_STEP = 10
CURRENT_GROUP = MIN_BB
GROUP_DIR = 1
GROUP_HOLD = 5
GROUP_COUNT = 0

# ----------------------------
# RANDOM SEED
# ----------------------------
random.seed()

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:
    # --- Group hold logic ---
    GROUP_COUNT += 1
    if GROUP_COUNT >= GROUP_HOLD:
        GROUP_COUNT = 0
        CURRENT_GROUP += GROUP_DIR * GROUP_STEP
        if CURRENT_GROUP >= MAX_BB:
            CURRENT_GROUP = MAX_BB
            GROUP_DIR = -1
        elif CURRENT_GROUP <= MIN_BB:
            CURRENT_GROUP = MIN_BB
            GROUP_DIR = 1

    # --- Base frequency within current group ---
    BB = CURRENT_GROUP + random.randint(0, GROUP_STEP-1)
    print(f"BB Group: {CURRENT_GROUP} | BB: {BB}")

    # --- Layer 1: ±O1 around BB ---
    FREQ1 = BB + O1 + random.uniform(-JITTER, JITTER)
    FREQ2 = BB - O1 + random.uniform(-JITTER, JITTER)

    # --- Layer 2: ±O2 relative to Layer 1 ---
    FREQ3 = FREQ1 + O2
    FREQ4 = FREQ1 - O2
    FREQ5 = FREQ2 + O2
    FREQ6 = FREQ2 - O2

    # --- Layer 3: ±O3 relative to Layer 2 ---
    FREQ7 = FREQ3 + O3
    FREQ8 = FREQ4 - O3

    # --- Run modules in parallel ---
    cmds = [
        ("./adf4351", BB),
        ("./adf43512", FREQ1),
        ("./adf43513", FREQ2),
        ("./adf43514", FREQ3),
        ("./adf43515", FREQ4),
        ("./adf43516", FREQ5),
        ("./adf43517", FREQ6),
        ("./adf43518", FREQ7),
        # Optionally add FREQ8 if you want a 9th module
    ]

    procs = []
    for cmd, freq in cmds:
        p = subprocess.Popen([cmd, f"{freq:.9f}", "25000000", str(C)])
        procs.append(p)
        #time.sleep(0.001)  # small spacing between module calls

    for p in procs:
        p.wait()

    # --- Optional jittered dwell ---
    dwell = random.uniform(0.0001, 0.0009)
    #time.sleep(dwell)
