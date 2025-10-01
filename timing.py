#!/usr/bin/env python3
import tkinter as tk
import os

FILE_PATH = "/home/pi/Desktop/nvalues.txt"
DEFAULT_T1 = 140
DEFAULT_T2 = 65

def pick_values():
    """Return T1 and T2 values to bash via stdout and save to file"""
    try:
        t1 = int(entry_t1.get())
    except ValueError:
        t1 = DEFAULT_T1
    try:
        t2 = int(entry_t2.get())
    except ValueError:
        t2 = DEFAULT_T2

    # Save to file
    with open(FILE_PATH, "w") as f:
        f.write(f"{t1} {t2}\n")

    print(f"{t1} {t2}")   # stdout for bash
    root.destroy()

def inc_entry(entry, step):
    """Increment/decrement entry value"""
    try:
        val = int(entry.get())
    except ValueError:
        val = 0
    val += step
    if val < 10:
        val = 10
    if val > 1000000:
        val = 1000000
    entry.delete(0, tk.END)
    entry.insert(0, str(val))

# GUI setup
root = tk.Tk()
root.title("Pick T1 and T2")

# Center window
win_w, win_h = 400, 400
screen_w = root.winfo_screenwidth()
screen_h = root.winfo_screenheight()
pos_x = int((screen_w / 2) - (win_w / 2))
pos_y = int((screen_h / 2) - (win_h / 2))
root.geometry(f"{win_w}x{win_h}+{pos_x}+{pos_y}")

label = tk.Label(root, text="Select T1 and T2 values (10 - 1,000,000):", font=("Arial", 12))
label.pack(pady=10)

# Load saved values if file exists
if os.path.exists(FILE_PATH):
    try:
        with open(FILE_PATH, "r") as f:
            saved = f.read().strip().split()
            if len(saved) == 2:
                start_t1, start_t2 = int(saved[0]), int(saved[1])
            else:
                start_t1, start_t2 = DEFAULT_T1, DEFAULT_T2
    except Exception:
        start_t1, start_t2 = DEFAULT_T1, DEFAULT_T2
else:
    start_t1, start_t2 = DEFAULT_T1, DEFAULT_T2

# Custom spinbox with large buttons
def make_spinbox(parent, label_text, default_value):
    frame = tk.Frame(parent)
    frame.pack(pady=10)

    tk.Label(frame, text=label_text, font=("Arial", 12)).pack()

    entry = tk.Entry(frame, width=12, font=("Arial", 18), justify="center")
    entry.insert(0, str(default_value))
    entry.pack()

    btn_frame = tk.Frame(frame)
    btn_frame.pack()

    btn_minus = tk.Button(btn_frame, text="−", font=("Arial", 16), width=4, height=2,
                          command=lambda e=entry: inc_entry(e, -5))
    btn_minus.pack(side=tk.LEFT, padx=5)

    btn_plus = tk.Button(btn_frame, text="+", font=("Arial", 16), width=4, height=2,
                         command=lambda e=entry: inc_entry(e, 5))
    btn_plus.pack(side=tk.LEFT, padx=5)

    return entry

# T1 control
entry_t1 = make_spinbox(root, "T1", start_t1)
# T2 control
entry_t2 = make_spinbox(root, "T2", start_t2)

# Submit button
submit_btn = tk.Button(root, text="Submit", command=pick_values,
                       font=("Arial", 14), width=12, height=2)
submit_btn.pack(pady=20)

root.mainloop()
