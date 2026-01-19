#!/usr/bin/env python3
import subprocess
import random
import time

# ----------------------------
# READ SG3 BASE FREQUENCIES
# ----------------------------
sg3_file = "/tmp/ramdisk/SG3.TXT"
with open(sg3_file, "r") as f:
    numbers = [int(x) for x in f.read().split() if x.isdigit()]

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
# OFFSETS (MHz)
# ----------------------------
O1 = 0.000003     # 3 Hz
O2 = 0.010000     # 10 kHz
O3 = 0.000003     # 3 Hz
JITTER = 0.000001

# ----------------------------
# MODULE GROUPS (4 SPINES)
# ----------------------------
SPINES = [
    ["./adf4351", "./adf43512"],
    ["./adf43513", "./adf43514"],
    ["./adf43515", "./adf43516"],
    ["./adf43517", "./adf43518"],
]

NUM_SPINES = len(SPINES)
PHI = 0.6180339887498949

# ----------------------------
# SPINE STATE
# ----------------------------
GROUP_STEP = 100
GROUP_HOLD = 10

spine_state = []
for _ in range(NUM_SPINES):
    spine_state.append({
        "current_bb": random.randint(MIN_BB, MAX_BB),
        "dir": random.choice([-1, 1]),
        "hold": random.randint(5, 20),
        "count": 0,
        "phases": [random.random(), random.random()],
        "locked": random.randint(0, 1),
        "lock_every": random.randint(3, 15),
        "lock_count": 0
    })

print("********** 4-SPINE LAYERED HETERODYNE RUNNING **********")

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:
    procs = []

    for si, spine in enumerate(spine_state):

        # ---- BB motion ----
        spine["count"] += 1
        if spine["count"] >= spine["hold"]:
            spine["count"] = 0
            spine["current_bb"] += spine["dir"] * GROUP_STEP

            if spine["current_bb"] >= MAX_BB:
                spine["current_bb"] = MAX_BB
                spine["dir"] = -1
            elif spine["current_bb"] <= MIN_BB:
                spine["current_bb"] = MIN_BB
                spine["dir"] = 1

        BB = spine["current_bb"] + random.randint(0, GROUP_STEP - 1)

        # ---- Layered offsets ----
        L1a = BB + O1 + random.uniform(-JITTER, JITTER)
        L1b = BB - O1 + random.uniform(-JITTER, JITTER)

        L2a = L1a + O2
        L2b = L1a - O2
        L2c = L1b + O2
        L2d = L1b - O2

        L3a = L2a + O3
        L3b = L2b - O3

        roles = [BB, L1a, L1b, L2a, L2b, L2c, L2d, L3a, L3b]

        # ---- Assign modules ----
        for mi, mod in enumerate(SPINES[si]):
            if mi == spine["locked"]:
                freq = roles[mi]
            else:
                spine["phases"][mi] = (spine["phases"][mi] + PHI) % 1.0
                idx = int(spine["phases"][mi] * len(roles))
                freq = roles[idx]

            p = subprocess.Popen(
                [mod, f"{freq:.9f}", "25000000", str(C)],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL
            )
            procs.append(p)

        # ---- Rotate lock ----
        spine["lock_count"] += 1
        if spine["lock_count"] >= spine["lock_every"]:
            spine["locked"] = 1 - spine["locked"]
            spine["lock_count"] = 0
            spine["lock_every"] = random.randint(3, 15)

    # ---- Synchronize ----
    for p in procs:
        p.wait()

    time.sleep(random.uniform(0.01, 0.000001))
