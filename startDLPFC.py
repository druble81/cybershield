#!/usr/bin/env python3
import subprocess
import random
import time
import os

# ----------------------------
# CONFIG
# ----------------------------
PHI = 0.6180339887498949
TOTAL_MODULES = 8
LOCK_CHANGE_INTERVAL = 20  # iterations before switching the locked module
MICRO_DWELL_MIN = 0.000001
MICRO_DWELL_MAX = 0.5
OFFSET = 500000  # fixed offset

# ----------------------------
# MODULE LIST
# ----------------------------
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
# READ SG3 BASE FREQUENCIES
# ----------------------------
sg3_file = "/tmp/ramdisk/SG3.TXT"
try:
    with open(sg3_file, "r") as f:
        numbers = [int(x) for x in f.read().split() if x.isdigit()]
        MIN_BB = numbers[0]
        MAX_BB = numbers[-1]
except:
    MIN_BB, MAX_BB = 120, 600
MIN_BB, MAX_BB = 120, 600

# ----------------------------
# READ POWER LEVEL
# ----------------------------
power_file = "/home/pi/Desktop/power.txt"
if os.path.exists(power_file):
    with open(power_file, "r") as f:
        C = f.read().strip()
else:
    C = "2"

print(f"C is set to: {C}")
print("**********----------DLPFC RUNNING----------**********")

# ----------------------------
# INITIALIZATION
# ----------------------------
phases = [random.random() for _ in range(TOTAL_MODULES)]
locked_module_index = random.randint(0, TOTAL_MODULES - 1)
iteration_counter = 0

GROUP_STEP = 100
CURRENT_GRP = MIN_BB
GROUP_DIR = 1
GROUP_HOLD = 15
GROUP_CNT = 0

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:
    iteration_counter += 1

    # ---- GROUP HOLD ----
    GROUP_CNT += 1
    if GROUP_CNT >= GROUP_HOLD:
        GROUP_CNT = 0
        CURRENT_GRP += GROUP_DIR * GROUP_STEP
        if CURRENT_GRP >= MAX_BB:
            CURRENT_GRP = MAX_BB
            GROUP_DIR = -1
        elif CURRENT_GRP <= MIN_BB:
            CURRENT_GRP = MIN_BB
            GROUP_DIR = 1

    # ---- RANDOMIZE BASE BB ----
    BB = CURRENT_GRP + random.randint(0, GROUP_STEP - 1)
    print(f"BB Group: {CURRENT_GRP} | BB: {BB}")

    # ---- DERIVED BASES ----
    BB1 = BB + 2
    BB2 = BB + 1
    BB3 = BB + 3

    # ---- HZ OFFSETS (L1/L2/L3 style collapse) ----
    hz1 = 5
    hz2 = 5
    hz3 = 4
    hz4 = 5

    # ---- DEFINE ROLES ----
    roles = [
        f"{BB}.{OFFSET:06d}",
        f"{BB}.{OFFSET + hz1:06d}",
        f"{BB1}.{OFFSET + hz2:06d}",
        f"{BB1}.{OFFSET:06d}",
        f"{BB2}.{OFFSET:06d}",
        f"{BB2}.{OFFSET + hz3:06d}",
        f"{BB3}.{OFFSET + hz4:06d}",
        f"{BB3}.{OFFSET:06d}",
    ]

    # ---- APPLY GOLDEN-RATIO ROTATION WITH LOCK COLLAPSE ----
    assignments = []
    for i, mod in enumerate(MODULES):
        if i == locked_module_index:
            # Locked module stays on its first role
            freq = roles[i]
        else:
            # Golden ratio decorrelation for other modules
            phases[i] = (phases[i] + PHI) % 1.0
            role_index = int(phases[i] * len(roles))
            freq = roles[role_index]
        assignments.append((mod, freq))

    # ---- PARALLEL EXECUTION ----
    procs = []
    for mod, freq in assignments:
        p = subprocess.Popen([mod, freq, "25000000", C])
        procs.append(p)
    for p in procs:
        p.wait()

    # ---- MICRO DWELL ----
    time.sleep(random.uniform(MICRO_DWELL_MIN, MICRO_DWELL_MAX))

    # ---- ROTATE LOCKED MODULE EVERY N ITERATIONS ----
    if iteration_counter % LOCK_CHANGE_INTERVAL == 0:
        locked_module_index = random.randint(0, TOTAL_MODULES - 1)
        LOCK_CHANGE_INTERVAL = random.randint(2, 5)
        print("[LOCK COLLAPSE ROTATION]")
