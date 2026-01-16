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
JITTER = 0.000001  # micro jitter ±1 Hz

# ----------------------------
# GROUP CONTROL
# ----------------------------
GROUP_STEP = 25
CURRENT_GROUP = MIN_BB
GROUP_DIR = 1
GROUP_HOLD = 15
GROUP_COUNT = 0

# ----------------------------
# MODULES & GOLDEN RATIO
# ----------------------------
MODULES = [
    "./adf4351", "./adf43512", "./adf43513", "./adf43514",
    "./adf43515", "./adf43516", "./adf43517", "./adf43518"
]

TOTAL_MODULES = len(MODULES)
PHI = 0.6180339887498949
phases = [random.random() for _ in range(TOTAL_MODULES)]

# ----------------------------
# LOCK COLLAPSE SETTINGS
# ----------------------------
LOCK_EVERY = 10      # iterations before changing locked module
locked_module = random.randint(0, TOTAL_MODULES-1)
iteration_count = 0

print("**********----------LAYERED HETERODYNE WITH LOCK COLLAPSE RUNNING----------**********")

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:
    iteration_count += 1

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

    # --- Base frequency ---
    BB = CURRENT_GROUP + random.randint(0, GROUP_STEP-1)
    print(f"BB Group: {CURRENT_GROUP} | BB: {BB}")

    # --- Layer offsets ---
    L1a = BB + O1 + random.uniform(-JITTER, JITTER)
    L1b = BB - O1 + random.uniform(-JITTER, JITTER)
    L2a = L1a + O2
    L2b = L1a - O2
    L2c = L1b + O2
    L2d = L1b - O2
    L3a = L2a + O3
    L3b = L2b - O3

    # --- Prepare roles list ---
    roles = [
        BB,
        L1a, L1b,
        L2a, L2b, L2c, L2d,
        L3a
    ]

    # --- Assign frequencies using golden ratio rotation ---
    assignments = []
    for i, mod in enumerate(MODULES):
        if i == locked_module:
            # keep locked module fixed
            freq = roles[i]
        else:
            phases[i] = (phases[i] + PHI) % 1.0
            role_index = int(phases[i] * len(roles))
            freq = roles[role_index]
        assignments.append((mod, freq))

    # --- Run all modules in parallel ---
    procs = []
    for mod, freq in assignments:
        p = subprocess.Popen([mod, f"{freq:.9f}", "25000000", str(C)])
        procs.append(p)
    for p in procs:
        p.wait()

    # --- Change locked module periodically ---
    if iteration_count >= LOCK_EVERY:
        locked_module = random.randint(0, TOTAL_MODULES-1)
        iteration_count = 0
        LOCK_EVERY = random.randint(2, 15)
        print("ROTATING LOCKS ")

    # --- Optional jittered dwell ---
    time.sleep(random.uniform(0.05, 0.000001))
