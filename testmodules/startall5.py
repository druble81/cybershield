#!/usr/bin/env python3
import subprocess
import random
import time
import os

# ----------------------------
# USER TUNABLES
# ----------------------------
TARGET_HZ   = 1
START_HZ    = 12
STEP_HZ     = 1
DWELL_BASE  = 6
DWELL_VAR   = 4
PHASE_STEP  = 3
REFCLK      = 25_000_000

POWER_FILE = "/home/pi/Desktop/power.txt"
SG3_FILE   = "/tmp/ramdisk/SG3.TXT"

PHI = 0.6180339887498949
TOTAL_MODULES = 8

# ----------------------------
# LOCK-COLLAPSE TUNABLES
# ----------------------------
LOCK_MIN = 2
LOCK_MAX = 15
LOCK_MODULE_INDEX = 5   # adf43518 (centered in your list)

lock_cycles = random.randint(LOCK_MIN, LOCK_MAX)
lock_counter = 0

# ----------------------------
# READ POWER
# ----------------------------
if os.path.exists(POWER_FILE):
    with open(POWER_FILE, "r") as f:
        C = f.read().strip()
else:
    C = "2"

print(f"Power: {C}")

# ----------------------------
# READ SG3 RANGE
# ----------------------------
try:
    with open(SG3_FILE, "r") as f:
        lines = [int(x) for x in f.read().split() if x.isdigit()]
        MIN_BB = 80
        MAX_BB = 280
except Exception as e:
    print(f"[Error] SG3 missing, using defaults: {e}")
    MIN_BB, MAX_BB = 80, 150

print(f"SG3 Range: {MIN_BB} - {MAX_BB}")

# ----------------------------
# MODULE LIST (ORDER MATTERS)
# ----------------------------
MODULES = [
    "./adf43513",
    "./adf43514",
    "./adf43515",
    "./adf43516",
    "./adf43517",
    "./adf43518",  # LOCK TARGET
    "./adf4351",
    "./adf43512",
]

# ----------------------------
# INITIAL VALUES
# ----------------------------
current_hz = START_HZ
phase_rot  = 0

# golden-ratio phase per module
phases = [random.random() for _ in range(TOTAL_MODULES)]

# ----------------------------
# HELPER
# ----------------------------
def run_modules(assignments):
    procs = []
    for mod, freq in assignments:
        p = subprocess.Popen([mod, freq, str(REFCLK), C])
        procs.append(p)
    for p in procs:
        p.wait()

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:

    # Clamp beat frequency
    if current_hz < TARGET_HZ:
        current_hz = TARGET_HZ

    # Base carrier
    BB = random.randint(MIN_BB, MAX_BB)

    # Stable offset
    OFFSET = random.randint(200_000, 700_000)

    # ----------------------------
    # BASE FREQUENCY ROLES
    # ----------------------------
    roles = [
        OFFSET,
        OFFSET + current_hz,
        OFFSET + current_hz * 2,
        OFFSET + PHASE_STEP,
        OFFSET + PHASE_STEP * 2,
        OFFSET,                    # collapse candidate
        OFFSET,
        OFFSET + current_hz,
    ]

    collapse_value = roles[5]

    # ----------------------------
    # LOCK-COLLAPSE LOGIC
    # ----------------------------
    lock_counter += 1
    locked = lock_counter <= lock_cycles

    if locked:
        roles.pop(5)

    # ----------------------------
    # ROTATE ROLES (golden-ratio)
    # ----------------------------
    step = max(1, int(len(roles) * PHI))
    roles = roles[step:] + roles[:step]

    if locked:
        roles.insert(LOCK_MODULE_INDEX, collapse_value)
    else:
        lock_counter = 0
        lock_cycles = random.randint(LOCK_MIN, LOCK_MAX)

    # ----------------------------
    # APPLY GOLDEN-RATIO DECORRELATION
    # ----------------------------
    assignments = []
    for i, mod in enumerate(MODULES):
        phases[i] = (phases[i] + PHI) % 1.0
        bb_offset = int(phases[i] * 7)

        freq = f"{BB + bb_offset}.{roles[i]:06d}"
        assignments.append((mod, freq))

    print(
        f"Carrier={BB}  Beat={current_hz}Hz  "
        f"Collapse={'LOCKED' if locked else 'FREE'} "
        f"{lock_counter}/{lock_cycles}"
    )

    # ----------------------------
    # RUN MODULES
    # ----------------------------
    run_modules(assignments)

    # ----------------------------
    # DWELL
    # ----------------------------
    time.sleep(DWELL_BASE + random.uniform(0, DWELL_VAR))

    # ----------------------------
    # PHASE ROTATION
    # ----------------------------
    phase_rot += PHASE_STEP
    if phase_rot > 20:
        phase_rot = 0

    # ----------------------------
    # RAMP DOWN
    # ----------------------------
    if current_hz > TARGET_HZ:
        current_hz -= STEP_HZ
    # if current_hz == TARGET_HZ:
        DWELL_BASE = 0.1
        DWELL_VAR = 0.2
        
