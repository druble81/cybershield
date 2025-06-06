import tkinter as tk
import subprocess
import os

BUTTONS_FILE = "buttons.txt"

# Load button definitions from file
def load_button_definitions(file_path):
    buttons = []
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"{file_path} not found.")
    
    with open(file_path, "r") as f:
        for line in f:
            if '|' in line:
                label, command = line.strip().split('|', 1)
                buttons.append({"label": label.strip(), "command": command.strip()})
    return buttons

# Run command and print directly to terminal
def run_command(command):
    print(f"\n> Running: {command}")
    process = subprocess.Popen(command, shell=True)
    process.wait()

# Build GUI
def create_menu(buttons):
    root = tk.Tk()
    root.title("Command Menu")

    for i, btn in enumerate(buttons):
        button = tk.Button(root, text=btn["label"], width=30, height=2,
                           command=lambda cmd=btn["command"]: run_command(cmd))
        button.grid(row=i, column=0, padx=10, pady=5)

    root.mainloop()

# Main program
if __name__ == "__main__":
    try:
        buttons = load_button_definitions(BUTTONS_FILE)
        create_menu(buttons)
    except Exception as e:
        print(f"Error: {e}")
