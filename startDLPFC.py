#!/usr/bin/env python3
import subprocess
import random
import time
import os

# ----------------------------
# CONFIG
# ----------------------------
PHI = 0.6180339887498949
TOTAL_MODULES = 9                      # now 9 modules (5 base + 4 hz)
LOCK_CHANGE_INTERVAL = 3               # iterations before switching locked module
MICRO_DWELL_MIN = 0.0001
MICRO_DWELL_MAX = 0.001
OFFSET = 500_000                       # fixed offset for hz calculations

# ----------------------------
# MODULE LIST (9 entries now)
# ----------------------------
MODULES = [
    "./adf4351",
    "./adf43512",
    "./adf43513",
    "./adf43514",
    "./adf43515",      # 5th module → base only (indices 0-4)
    "./adf43516",      # 6th module → hz offset (indices 5-8)
    "./adf43517",
    "./adf43518",
    "./adf43519"       # 9th module added
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
except Exception:
    MIN_BB, MAX_BB = 35, 8800

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

# ----------------------------
# FENCE SWEEP CONFIG
# ----------------------------
FENCE_STEPS = 16                     # vertical height of your ASCII fence
FENCE_WIDTH = MAX_BB - MIN_BB
FENCE_STEP = FENCE_WIDTH // (FENCE_STEPS - 1) if FENCE_STEPS > 1 else 0

# Precompute fence positions (expand → collapse pattern)
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

    # ---- HZ OFFSETS FOR THE 4 MODULES WITH HZ ----
    hz1 = 2
    hz2 = 7
    hz3 = 4
    hz4 = 3

    # ---- DEFINE ROLES (5 base-only + 4 with hz offset) ----
    roles = []
    for i, BB in enumerate(BB_values):
        if i < 5:                      # first 5 modules → base only
            freq_str = f"{BB}.000000"  # no hz offset (decimal format)
        else:                          # last 4 modules → base + hz offset
            hz_val = [hz1, hz2, hz3, hz4][i - 5]
            freq_str = f"{BB}.{OFFSET + hz_val:06d}"

        roles.append(freq_str)

    # ---- APPLY GOLDEN-RATIO ROTATION WITH LOCK COLLAPSE ----
    assignments = []
    for i, mod in enumerate(MODULES):
        if i == locked_module_index:
            # Locked module stays on its first role (no rotation)
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
        p = subprocess.Popen([mod, freq, "25000000", C, "--pd"])
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
