#!/usr/bin/env python3

import os
import time
import random
import subprocess

# --------------------------------------------------
# SETUP
# --------------------------------------------------

os.system("clear")
os.chdir("/home/pi/Desktop/testmodules")

print(" **********----------Anti-PAIN RUNNING----------**********")
print(" **********----------Anti-PAIN RUNNING----------**********")

SG3_FILE = "/tmp/ramdisk/SG3.TXT"
POWER_FILE = "/home/pi/Desktop/power.txt"

# --------------------------------------------------
# READ NUMBERS FROM SG3.TXT
# --------------------------------------------------

numbers = []

if os.path.isfile(SG3_FILE):
    with open(SG3_FILE, "r") as f:
        for token in f.read().split():
            if token.isdigit():
                numbers.append(int(token))

if not numbers:
    print("No numbers found in /tmp/ramdisk/SG3.TXT")
    exit(1)

MIN_BB = numbers[0]
MAX_BB = numbers[-1]

# --------------------------------------------------
# GROUP CONTROL
# --------------------------------------------------

GROUP_STEP = 100
CURRENT_GROUP = MIN_BB
GROUP_DIR = 1

GROUP_HOLD = 15
GROUP_COUNT = 0

# --------------------------------------------------
# READ POWER VALUE
# --------------------------------------------------

if os.path.isfile(POWER_FILE):
    try:
        with open(POWER_FILE, "r") as f:
            C = int(f.read().strip())
    except ValueError:
        C = 2
else:
    C = 2

# --------------------------------------------------
# CONSTANTS
# --------------------------------------------------

offset = 700000

hz1 = 40
hz2 = 10
hz3 = 10
hz4 = 40

# --------------------------------------------------
# MAIN LOOP
# --------------------------------------------------

while True:

    # ---- GROUP HOLD LOGIC ----
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

    # ---- RANDOMIZE WITHIN GROUP ----
    BB = CURRENT_GROUP + random.randint(0, GROUP_STEP - 1)

    print(f"BB Group: {CURRENT_GROUP}  |  BB: {BB}")

    BB1 = BB - 2
    BB2 = BB + 1
    BB3 = BB - 1

    # ---- MODULE COMMANDS ----
    cmds = [
        ["./adf4351",  f"{BB}.{offset}",            "25000000", str(C)],
        ["./adf43512", f"{BB}.{offset + hz1}",      "25000000", str(C)],

        ["./adf43513", f"{BB1}.{offset + hz2}",     "25000000", str(C)],
        ["./adf43514", f"{BB1}.{offset}",           "25000000", str(C)],

        ["./adf43515", f"{BB2}.{offset}",           "25000000", str(C)],
        ["./adf43516", f"{BB2}.{offset + hz3}",     "25000000", str(C)],

        ["./adf43517", f"{BB3}.{offset + hz4}",     "25000000", str(C)],
        ["./adf43518", f"{BB3}.{offset}",           "25000000", str(C)],
    ]

    # Fire all except last in background-equivalent
    for cmd in cmds[:-1]:
        subprocess.Popen(cmd)

    # Last one blocking (matches your Bash behavior)
    subprocess.call(cmds[-1])

    # ---- RANDOM MICRO-SLEEP ----
    time.sleep(random.uniform(0, 0.0000001))
