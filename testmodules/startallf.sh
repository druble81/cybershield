#!/usr/bin/env python3
import subprocess
import random
import time
import math

# ----------------------------
# LOAD SG3 FREQUENCIES
# ----------------------------
sg3_file = "/tmp/ramdisk/SG3.TXT"
with open(sg3_file, "r") as f:
    numbers = [int(x) for x in f.read().split() if x.isdigit()]

# SINGLE shared base frequency
base = random.choice(numbers)
print(f"[DEBUG] BASE FREQUENCY: {base}")

# ----------------------------
# POWER LEVEL
# ----------------------------
try:
    with open("/home/pi/Desktop/power.txt", "r") as f:
        C = f.read().strip()
except FileNotFoundError:
    C = "2"

# ----------------------------
# DRIFT SETTINGS
# ----------------------------
BASE_DELTA = 0.003000      # 3000 Hz
FINAL_OFFSET = 0.000005    # 5 Hz

DRIFT_AMPLITUDE = 0.000200  # ±200 Hz
DRIFT_SPEED = 0.2           # slower = smoother

# ----------------------------
# MODULES
# ----------------------------
MODULES = [
    "./adf4351", "./adf43512",
    "./adf43513", "./adf43514",
    "./adf43515", "./adf43516",
    "./adf43517", "./adf43518",
]

print("********** DRIFTING 3000Hz → LOCKED 5Hz MODE **********")

t = 0.0

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:

    # Smooth drift using sine wave
    drift = DRIFT_AMPLITUDE * math.sin(t)

    delta_A = BASE_DELTA + drift
    delta_B = delta_A + FINAL_OFFSET  # ALWAYS 5 Hz apart

    # ALL modules derived from SAME base
    freqs = [
        base,
        base + delta_A,
        base,
        base + delta_B,
        base,
        base + delta_A,
        base,
        base + delta_B,
    ]

    procs = []
    for mod, freq in zip(MODULES, freqs):
        p = subprocess.Popen(
            [mod, f"{freq:.9f}", "25000000", str(C)],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
        procs.append(p)

    for p in procs:
        p.wait()

    t += DRIFT_SPEED
    time.sleep(0.3)
