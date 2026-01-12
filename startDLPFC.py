#!/usr/bin/env python3
import subprocess
import random
import time
import os

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
power_file = "/home/pi/Desktop/power.txt"
if os.path.exists(power_file):
    with open(power_file, "r") as f:
        C = f.read().strip()
else:
    C = "2"

# ----------------------------
# GROUP CONTROL
# ----------------------------
GROUP_STEP = 25
CURRENT_GROUP = MIN_BB
GROUP_DIR = 1
GROUP_HOLD = 75
GROUP_COUNT = 0

# ----------------------------
# FIXED OFFSET (Hz injected via decimal)
# ----------------------------
OFFSET = 700000   # .700000 MHz

# ----------------------------
# RANDOM SEED
# ----------------------------
random.seed()

print("**********----------DLPFC RUNNING----------**********")

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:

    # ---- GROUP HOLD ----
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

    # ---- RANDOMIZE BB ----
    BB = CURRENT_GROUP + random.randint(0, GROUP_STEP - 1)

    print(f"BB Group: {CURRENT_GROUP} | BB: {BB}")

    # ---- DERIVED BASES ----
    BB1 = BB - 2
    BB2 = BB + 1
    BB3 = BB - 1

    # ---- HZ OFFSETS ----
    hz1 = 5
    hz2 = 3
    hz3 = 4
    hz4 = random.randint(4, 5)

    # ---- FREQUENCY FORMATTER ----
    def f(mhz, hz):
        return f"{mhz}.{OFFSET + hz:06d}"

    # ---- COMMAND MAP (exact bash equivalence) ----
    cmds = [
        ("./adf4351",  f"{BB}.{OFFSET:06d}"),
        ("./adf43512", f(BB,  hz1)),
        ("./adf43513", f(BB1, hz2)),
        ("./adf43514", f"{BB1}.{OFFSET:06d}"),
        ("./adf43515", f"{BB2}.{OFFSET:06d}"),
        ("./adf43516", f(BB2, hz3)),
        ("./adf43517", f(BB3, hz4)),
        ("./adf43518", f"{BB3}.{OFFSET:06d}"),
    ]

    # ---- PARALLEL EXECUTION ----
    procs = []
    for cmd, freq in cmds:
        p = subprocess.Popen([cmd, freq, "25000000", C])
        procs.append(p)

    for p in procs:
        p.wait()

    # ---- OPTIONAL MICRO DWELL (commented to preserve bash behavior) ----
    # time.sleep(random.uniform(0.00001, 0.00009))
