import tkinter as tk
import sys

def select_value():
    selected = {"value": None}

    def button_pressed(value):
        selected["value"] = value
        root.destroy()

    root = tk.Tk()
    root.title("Select Value")
    root.geometry("250x520")
    root.resizable(False, False)

    values = [0, 10, 15, 20, 25, 30, 40, 60, 80, 100, 200, 430, 620]

    for v in values:
        btn = tk.Button(
            root,
            text=str(v),
            width=12,
            height=1,
            command=lambda val=v: button_pressed(val)
        )
        btn.pack(pady=4)

    root.mainloop()
    return selected["value"]

value = select_value()

# IMPORTANT: print ONLY the value for bash
if value is not None:
    print(value)
    sys.exit(0)
else:
    sys.exit(1)
