# touchscreen_menu.py
# Clean, reconfigurable touchscreen menu for 800x600 displays (Raspberry Pi)

import tkinter as tk
from tkinter import messagebox
import subprocess

# ---------------- CONFIGURATION ----------------
SCREEN_W = 600
SCREEN_H = 800

# Main program buttons (left grid)
MAIN_PROGRAMS = [
    {"label": "Normal", "cmd": "bash /home/pi/Desktop/startall.sh &"},
    {"label": "Burst", "cmd": "bash /home/pi/Desktop/sa.sh &"},
    {"label": "Full 10K", "cmd": "bash /home/pi/Desktop/10k.sh &"},
    {"label": "Full Coverage", "cmd": "bash /home/pi/Desktop/sa2.sh &"},
    {"label": "Random", "cmd": "bash /home/pi/Desktop/sa3.sh &"},
    {"label": "Sleep", "cmd": "bash /home/pi/Desktop/startall5.sh &"},
    {"label": "Wake", "cmd": "bash /home/pi/Desktop/startall6.sh &"},
]

# Right-side configurable buttons (future menus/features)
SIDE_BUTTONS = [
    {"label": "LOCK", "cmd": None},
    {"label": "V2K", "cmd": None},
    {"label": "300-400", "cmd": None},
    {"label": "495-505", "cmd": None},
    {"label": "2150-2350", "cmd": None},
    {"label": "4100-4200", "cmd": None},
]

LOADRD = "/home/pi/Desktop/loadrd.sh"
MIN_FREQ = 35
MAX_FREQ = 4400

# ---------------- UI CLASSES ----------------

class NumericKeypad(tk.Toplevel):
    def __init__(self, master, callback):
        super().__init__(master)
        self.callback = callback
        self.value = ""
        self.title("Enter Value")
        self.geometry("300x400")

        self.display = tk.Label(self, text="", font=("Arial", 24), bg="white", anchor="e")
        self.display.pack(fill="x", padx=10, pady=10)

        grid = tk.Frame(self)
        grid.pack(expand=True)

        keys = [
            "7","8","9",
            "4","5","6",
            "1","2","3",
            "0","Del","OK"
        ]

        for i, key in enumerate(keys):
            def action(k=key): self.press(k)
            tk.Button(grid, text=key, font=("Arial", 18), command=action)
            .grid(row=i//3, column=i%3, sticky="nsew", padx=5, pady=5)

        for i in range(3):
            grid.columnconfigure(i, weight=1)
        for i in range(4):
            grid.rowconfigure(i, weight=1)

    def press(self, key):
        if key == "Del":
            self.value = self.value[:-1]
        elif key == "OK":
            self.callback(self.value)
            self.destroy()
            return
        else:
            self.value += key
        self.display.config(text=self.value)

class TouchMenu(tk.Tk):
    def __init__(self):
        super().__init__()
        self.geometry(f"{SCREEN_W}x{SCREEN_H}")
        self.title("Touch Menu")
        self.selected_btn = None
        self.range_low = None
        self.range_high = None

        self.build_ui()

    def build_ui(self):
        left = tk.Frame(self)
        left.pack(side="left", fill="both", expand=True)

        right = tk.Frame(self, width=160)
        right.pack(side="right", fill="y")

        # Main programs
        for i, prog in enumerate(MAIN_PROGRAMS):
            btn = tk.Button(left, text=prog['label'], font=("Arial", 20), height=2,
                            command=lambda p=prog, b=i: self.run_program(p, b))
            btn.grid(row=i, column=0, sticky="ew", padx=10, pady=6)
            left.grid_rowconfigure(i, weight=1)
            left.grid_columnconfigure(0, weight=1)
            prog['button'] = btn

        # Range selector
        range_frame = tk.Frame(left)
        range_frame.grid(row=len(MAIN_PROGRAMS), column=0, pady=10)

        self.range_label = tk.Label(range_frame, text="Custom Range", font=("Arial", 16))
        self.range_label.pack(pady=4)

        tk.Button(range_frame, text="Set Range", font=("Arial", 18),
                  command=self.set_range).pack(pady=6)

        # Side buttons
        for sb in SIDE_BUTTONS:
            tk.Button(right, text=sb['label'], font=("Arial", 16), height=2)
            .pack(fill="x", padx=6, pady=6)

    def highlight(self, index):
        for i, prog in enumerate(MAIN_PROGRAMS):
            prog['button'].config(bg="lightgray")
        MAIN_PROGRAMS[index]['button'].config(bg="lightgreen")

    def run_program(self, prog, index):
        self.highlight(index)
        subprocess.call(prog['cmd'], shell=True)

    def set_range(self):
        NumericKeypad(self, self.set_low)

    def set_low(self, value):
        try:
            val = int(value)
            if not MIN_FREQ <= val <= MAX_FREQ:
                raise ValueError
            self.range_low = val
            NumericKeypad(self, self.set_high)
        except ValueError:
            messagebox.showerror("Invalid", "Value must be 35–4400")

    def set_high(self, value):
        try:
            val = int(value)
            if not (self.range_low < val <= MAX_FREQ):
                raise ValueError
            self.range_high = val
            self.range_label.config(text=f"Range: {self.range_low}-{self.range_high}")
            subprocess.call(["bash", LOADRD, str(self.range_low), str(self.range_high)])
        except ValueError:
            messagebox.showerror("Invalid", "High must be greater than Low")

# ---------------- RUN ----------------

if __name__ == '__main__':
    TouchMenu().mainloop()
