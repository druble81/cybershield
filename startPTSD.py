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
LOCK_CHANGE_INTERVAL = 10 # iterations before switching the locked module
MICRO_DWELL_MIN = 0.000000001
MICRO_DWELL_MAX = 5
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
    MIN_BB, MAX_BB = 35, 4400

MIN_BB, MAX_BB = 35, 4400
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
print("**********----------ANTI PTSD RUNNING----------**********")

# ----------------------------
# INITIALIZATION
# ----------------------------
phases = [random.random() for _ in range(TOTAL_MODULES)]
locked_module_index = random.randint(0, TOTAL_MODULES - 1)
iteration_counter = 0

GROUP_STEP = 100
CURRENT_GRP = MIN_BB
GROUP_DIR = 1
GROUP_HOLD = 10
GROUP_CNT = 0

# ----------------------------
# FENCE SWEEP CONFIG
# ----------------------------
FENCE_STEPS = 16          # vertical height of your ASCII fence
FENCE_WIDTH = MAX_BB - MIN_BB
FENCE_STEP = FENCE_WIDTH // (FENCE_STEPS - 1)

# Precompute fence positions (expand → collapse)
fence_positions = []
for i in range(FENCE_STEPS):
    fence_positions.append(MIN_BB + i * FENCE_STEP)
for i in range(FENCE_STEPS - 2, 0, -1):
    fence_positions.append(MIN_BB + i * FENCE_STEP)

fence_len = len(fence_positions)

# Each module starts offset in the fence
fence_phase = [i * (fence_len // TOTAL_MODULES) for i in range(TOTAL_MODULES)]
fence_tick = 0


# ----------------------------
# MAIN LOOP
# ----------------------------
while True:
    iteration_counter += 1

    # ---- FENCE SWEEP ADVANCE ----
    fence_tick = (fence_tick + 1) % fence_len

    BB_values = []
    for i in range(TOTAL_MODULES):
        idx = (fence_tick + fence_phase[i]) % fence_len
        BB_values.append(fence_positions[idx])

    # ---- DERIVED BASES ----
    BB1 = BB_values[0]
    BB2 = BB_values[1]
    BB3 = BB_values[2]


    # ---- HZ OFFSETS (L1/L2/L3 style collapse) ----
    hz1 = 120
    hz2 = 5
    hz3 = random.randint(19, 20)
    hz4 = 420

    # ---- DEFINE ROLES ----
    roles = []
    for i, BB in enumerate(BB_values):
        if i % 2 == 0:
            hz = OFFSET
        else:
            hz = OFFSET + [hz1, hz2, hz3, hz4][i % 4]

        roles.append(f"{BB}.{hz:06d}")


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
