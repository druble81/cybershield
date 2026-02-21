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

print(f"[DEBUG] MIN_BB = {MIN_BB}, MAX_BB = {MAX_BB}")

# ----------------------------
# POWER LEVEL
# ----------------------------
try:
    with open("/home/pi/Desktop/power.txt", "r") as f:
        C = f.read().strip()
except FileNotFoundError:
    C = "2"

print(f"[DEBUG] POWER LEVEL = {C}")

# ----------------------------
# OFFSETS (MHz)
# ----------------------------
O1 = 0.000002     # 3 Hz
O2 = 0.000001     # 10 Hz
O3 = 0.000002     # 3 Hz
JITTER = 0.000001

print(f"[DEBUG] OFFSETS: O1={O1}, O2={O2}, O3={O3}, JITTER={JITTER}")

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

print(f"[DEBUG] NUM_SPINES = {NUM_SPINES}, PHI = {PHI}")

# ----------------------------
# SPINE STATE
# ----------------------------
GROUP_STEP = 100
GROUP_HOLD = 10

spine_state = []
for si in range(NUM_SPINES):
    state = {
        "current_bb": random.randint(MIN_BB, MAX_BB),
        "dir": random.choice([-1, 1]),
        "hold": random.randint(5, 20),
        "count": 0,
        "phases": [random.random(), random.random()],
        "locked": random.randint(0, 1),
        "lock_every": random.randint(3, 15),
        "lock_count": 0
    }
    spine_state.append(state)
    print(f"[DEBUG] Initial spine_state[{si}] = {state}")

# ----------------------------
# FENCE SWEEP CONFIG
# ----------------------------
FENCE_STEPS = 16
FENCE_WIDTH = MAX_BB - MIN_BB
FENCE_STEP = max(1, FENCE_WIDTH // (FENCE_STEPS - 1))

fence_positions = []
for i in range(FENCE_STEPS):
    fence_positions.append(MIN_BB + i * FENCE_STEP)
for i in range(FENCE_STEPS - 2, 0, -1):
    fence_positions.append(MIN_BB + i * FENCE_STEP)

fence_len = len(fence_positions)
fence_tick = 0

fence_phase = [i * (fence_len // NUM_SPINES) for i in range(NUM_SPINES)]
layer_offsets = [0, fence_len // 4, fence_len // 2]

NUM_LAYERS = len(layer_offsets)

print(f"[DEBUG] FENCE: len={fence_len}, phases={fence_phase}, layer_offsets={layer_offsets}")

print("********** 4 LAYERED HETERODYNE RUNNING **********")

# ----------------------------
# MAIN LOOP
# ----------------------------
while True:
    fence_tick = (fence_tick + 1) % fence_len
    layer_offsets = [0, fence_len//4, fence_len//2]

    procs = []

    for si, spine in enumerate(spine_state):
        layer = si % NUM_LAYERS
        idx = (fence_tick + fence_phase[si] + layer_offsets[layer]) % fence_len
        BB = fence_positions[idx]

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

        #print(f"[DEBUG] Spine {si}: BB={BB:.6f}, roles={roles}")

        # ---- Assign modules ----
        for mi, mod in enumerate(SPINES[si]):
            if mi == spine["locked"]:
                freq = roles[mi]
            else:
                spine["phases"][mi] = (spine["phases"][mi] + PHI) % 1.0
                idx_role = int(spine["phases"][mi] * len(roles))
                freq = roles[idx_role]

            #print(f"[DEBUG] Module {mod} assigned freq={freq:.9f} (locked={spine['locked']}, phase={spine['phases'][mi]:.3f})")

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
            #print(f"[DEBUG] Spine {si} lock toggled to {spine['locked']}, next lock_every={spine['lock_every']}")

    # ---- Synchronize ----
    for p in procs:
        p.wait()

    time.sleep(random.uniform(0.4, 0.1))
