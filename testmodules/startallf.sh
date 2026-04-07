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

base = random.sample(numbers, 4)
print(f"[DEBUG] BASE FREQUENCIES: {base}")

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

    freqs = [
        base[0], base[0] + delta_A,
        base[1], base[1] + delta_B,
        base[2], base[2] + delta_A,
        base[3], base[3] + delta_B,
    ]

    #print(f"[DEBUG] drift={drift*1e6:.1f} Hz | ΔA={delta_A*1e6:.1f} Hz | ΔB={delta_B*1e6:.1f} Hz")

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
    time.sleep(0.05)
