import tkinter as tk
from tkinter import simpledialog, messagebox
import subprocess
import json
import os
import threading
import time

SAVE_FILE = "/home/pi/Desktop/saved_programs.json"

# A dictionary mapping program names to their shell commands.
PROGRAM_OPTIONS = {
    "10k": "bash /home/pi/Desktop/10k.sh &",
    "Normal": "bash /home/pi/Desktop/startall.sh &",
    "Burst": "bash /home/pi/Desktop/sa.sh &",
    "Full Coverage": "bash /home/pi/Desktop/sa2.sh &",
    "DLPFC": "bash /home/pi/Desktop/startDLPFC.sh &",
    "Anti-PTSD": "bash /home/pi/Desktop/startPTSD.sh &",
    "Sleep": "bash /home/pi/Desktop/startall5.sh &",
    "Wake": "bash /home/pi/Desktop/startall6.sh &",
    "PFC": "bash /home/pi/Desktop/startall3.sh &",
    "Quad H": "bash /home/pi/Desktop/testmodules/startall.sh &",
    "V2K": "bash /home/pi/Desktop/testmodules/startall2.sh &",
    "V2K2": "bash /home/pi/Desktop/testmodules/startall2-2.sh &",
    "N2": "bash /home/pi/Desktop/n2/startall.sh &",
    "N3": "bash /home/pi/Desktop/n3/startall.sh &",
    "N4": "bash /home/pi/Desktop/n4/startall.sh &",
    "10k2": "bash /home/pi/Desktop/10k2/10k.sh &",
    "10K3": "bash /home/pi/Desktop/10k3/10k.sh &",
    "10k4": "bash /home/pi/Desktop/10k4/10k.sh &",
    "Full BAP": "bash /home/pi/Desktop/sa7.sh &",
    "N4 Burst Mode": "bash /home/pi/Desktop/sa5.sh&",
    "N4 Burst pulse": "bash /home/pi/Desktop/sa4.sh&",
    "Full Burst": "bash /home/pi/Desktop/sa6.sh&",
    "Pain Mode": "bash /home/pi/Desktop/startDLPFC2.sh&"
}

FONT_STYLE = ("TkDefaultFont", 12)

def normalize_decimal_string(value_str):
    """Normalizes decimal strings, e.g., '.5' becomes '0.5' and '.' becomes '0.0'."""
    if isinstance(value_str, str):
        value_str = value_str.strip()
        if value_str == ".":
            return "0.0"
        if value_str.startswith("."):
            return "0" + value_str
    return value_str

def validate_interval(interval_str):
    """Checks if the interval is a whole number between 1 and 2000."""
    try:
        val = float(interval_str)
        if val != int(val):
            return False, ""
        
        interval_val = int(val)
        if 1 <= interval_val <= 2000:
            return True, str(interval_val)
        else:
            return False, ""
    except (ValueError, TypeError):
        return False, ""

class KeypadWindow(tk.Toplevel):
    """A pop-up window with a numerical keypad for data entry."""
    def __init__(self, master, variable):
        super().__init__(master)
        self.title("Enter Value")
        self.variable = variable
        self.value = ""

        self.display = tk.Label(self, text="", font=("TkDefaultFont", 18), relief="sunken", bg="white", anchor="e", width=12)
        self.display.pack(pady=10)

        btn_frame = tk.Frame(self)
        btn_frame.pack()

        buttons = [
            ['7', '8', '9'],
            ['4', '5', '6'],
            ['1', '2', '3'],
            ['0', '.', 'Del']
        ]

        for r, row in enumerate(buttons):
            for c, char in enumerate(row):
                b = tk.Button(btn_frame, text=char, font=("TkDefaultFont", 14), width=5, command=lambda ch=char: self.press(ch))
                b.grid(row=r, column=c, padx=5, pady=5)

        tk.Button(self, text="Done", font=FONT_STYLE, command=self.done).pack(pady=10)

    def press(self, char):
        if char == "Del":
            self.value = self.value[:-1]
        elif char == ".":
            if '.' not in self.value:
                self.value += '.'
        else:
            self.value += char
        self.display.config(text=self.value)

    def done(self):
        self.variable.set(self.value)
        self.destroy()

class AddProgramWindow(tk.Toplevel):
    """A window for creating a new program or editing an existing one."""
    def __init__(self, master, edit_mode=False, program_data=None, program_index=None):
        super().__init__(master)
        self.title("Add Program")
        self.geometry("1035x510")
        self.center_window()
        self.master = master
        self.edit_mode = edit_mode
        self.program_index = program_index
        self.selected_scripts = []

        # Program name and loop checkbox
        tk.Label(self, text="Program Name:", font=FONT_STYLE).grid(row=0, column=0, sticky="w", padx=5, pady=5)
        self.name_entry = tk.Entry(self, font=FONT_STYLE)
        self.name_entry.grid(row=0, column=1, sticky="ew", padx=5, pady=5, columnspan=3)
        self.loop_var = tk.BooleanVar()
        tk.Checkbutton(self, text="Loop Program", variable=self.loop_var, font=FONT_STYLE).grid(row=0, column=4, sticky="w", padx=5, pady=5)

        self.available_listbox = tk.Listbox(self, font=FONT_STYLE, selectmode=tk.SINGLE, height=22)
        for key in PROGRAM_OPTIONS.keys():
            self.available_listbox.insert(tk.END, key)
        self.available_listbox.grid(row=2, column=0, rowspan=4, sticky="ns", padx=5, pady=5)

        btn_frame = tk.Frame(self)
        btn_frame.grid(row=2, column=1, sticky="n", pady=5)
        tk.Button(btn_frame, text="Add →", font=FONT_STYLE, command=self.add_script).pack(pady=10)
        tk.Button(btn_frame, text="← Remove", font=FONT_STYLE, command=self.remove_script).pack(pady=10)

        self.selected_listbox = tk.Listbox(self, font=FONT_STYLE, height=21)
        self.selected_listbox.grid(row=2, column=2, rowspan=4, sticky="ns", padx=5, pady=5)

        self.detail_frame = tk.Frame(self)
        self.detail_frame.grid(row=2, column=3, rowspan=4, sticky="nsew", padx=10, pady=5)

        tk.Label(self.detail_frame, text="Primary Low:", font=FONT_STYLE).grid(row=0, column=0, sticky="w")
        self.primary_low_var = tk.StringVar(value="35")
        self.primary_low_entry = tk.Entry(self.detail_frame, textvariable=self.primary_low_var, font=FONT_STYLE)
        self.primary_low_entry.grid(row=0, column=1)
        self.primary_low_entry.bind("<Button-1>", lambda e: self.open_keypad(self.primary_low_var))

        tk.Label(self.detail_frame, text="Primary High:", font=FONT_STYLE).grid(row=1, column=0, sticky="w")
        self.primary_high_var = tk.StringVar(value="4400")
        self.primary_high_entry = tk.Entry(self.detail_frame, textvariable=self.primary_high_var, font=FONT_STYLE)
        self.primary_high_entry.grid(row=1, column=1)
        self.primary_high_entry.bind("<Button-1>", lambda e: self.open_keypad(self.primary_high_var))

        tk.Label(self.detail_frame, text="Duration:", font=FONT_STYLE).grid(row=2, column=0, sticky="w")
        self.duration_var = tk.StringVar(value="1")
        self.duration_entry = tk.Entry(self.detail_frame, textvariable=self.duration_var, font=FONT_STYLE)
        self.duration_entry.grid(row=2, column=1)
        self.duration_entry.bind("<Button-1>", lambda e: self.open_keypad(self.duration_var))
        
        tk.Label(self.detail_frame, text="Interval:", font=FONT_STYLE).grid(row=3, column=0, sticky="w")
        self.interval_var = tk.StringVar(value="1")
        self.interval_entry = tk.Entry(self.detail_frame, textvariable=self.interval_var, font=FONT_STYLE)
        self.interval_entry.grid(row=3, column=1)
        self.interval_entry.bind("<Button-1>", lambda e: self.open_keypad(self.interval_var))

        tk.Button(self.detail_frame, text="Update Script Details", font=FONT_STYLE, command=self.update_script_details).grid(row=4, column=0, columnspan=2, pady=10)

        self.selected_listbox.bind("<<ListboxSelect>>", self.on_select_script)
        
        if edit_mode and program_data:
            self.name_entry.insert(0, program_data["name"])
            self.loop_var.set(program_data["loop"])
            self.selected_scripts = program_data.get("steps", [])
            
            for step in self.selected_scripts:
                step.setdefault("primary_low", "35")
                step.setdefault("primary_high", "4400")
                step.setdefault("duration", "1")
                step.setdefault("interval", "1")

            self.update_selected_listbox()
            if self.selected_scripts:
                self.selected_listbox.selection_set(0)
                self.on_select_script(None)

        tk.Button(self, text="Save Program", font=FONT_STYLE, command=self.save_program).grid(row=3, column=2, columnspan=5, pady=10)

    def center_window(self):
        self.update_idletasks()
        width = self.winfo_width()
        height = self.winfo_height()
        x = (self.winfo_screenwidth() // 2) - (width // 2)
        y = (self.winfo_screenheight() // 2) - (height // 2)
        self.geometry(f"{width}x{height}+{x}+{y}")

    def open_keypad(self, variable):
        KeypadWindow(self, variable)
    
    def save_program(self):
        name = self.name_entry.get().strip()
        if not name:
            messagebox.showerror("Error", "Program must have a name")
            return
            
        for i, step in enumerate(self.selected_scripts):
            interval_str = step.get('interval', '1')
            is_valid, _ = validate_interval(interval_str)
            if not is_valid:
                messagebox.showerror(
                    "Invalid Interval",
                    f"The interval for script '{step['name']}' (step {i+1}) is invalid.\n\n"
                    "It must be a whole number between 1 and 2000."
                )
                return

        for step in self.selected_scripts:
            step['primary_low'] = normalize_decimal_string(step.get('primary_low', '35'))
            step['primary_high'] = normalize_decimal_string(step.get('primary_high', '4400'))
            step['duration'] = normalize_decimal_string(step.get('duration', '1'))
            is_valid, cleaned_interval = validate_interval(step.get('interval', '1'))
            if is_valid:
                step['interval'] = cleaned_interval

        program = {
            "name": name,
            "loop": self.loop_var.get(),
            "steps": self.selected_scripts
        }

        if self.edit_mode and self.program_index is not None:
            self.master.programs[self.program_index] = program
        else:
            self.master.programs.append(program)

        self.master.save_programs()
        self.master.update_listbox()
        self.destroy()

    def add_script(self):
        selection = self.available_listbox.curselection()
        if not selection:
            return
        script_name = self.available_listbox.get(selection[0])
        self.selected_scripts.append({
            "script": PROGRAM_OPTIONS[script_name],
            "name": script_name,
            "primary_low": self.primary_low_var.get(),
            "primary_high": self.primary_high_var.get(),
            "duration": self.duration_var.get(),
            "interval": self.interval_var.get()
        })
        self.update_selected_listbox()
        self.selected_listbox.selection_clear(0, tk.END)
        self.selected_listbox.selection_set(tk.END)
        self.selected_listbox.event_generate("<<ListboxSelect>>")

    def remove_script(self):
        selection = self.selected_listbox.curselection()
        if not selection:
            return
        del self.selected_scripts[selection[0]]
        self.update_selected_listbox()

    def update_selected_listbox(self):
        self.selected_listbox.delete(0, tk.END)
        for s in self.selected_scripts:
            self.selected_listbox.insert(tk.END, s['name'])

    def on_select_script(self, event):
        selection = self.selected_listbox.curselection()
        if not selection:
            return
        s = self.selected_scripts[selection[0]]
        self.primary_low_var.set(s.get('primary_low', '35'))
        self.primary_high_var.set(s.get('primary_high', '4400'))
        self.duration_var.set(s.get('duration', '1'))
        self.interval_var.set(s.get('interval', '1'))

    def update_script_details(self):
        selection = self.selected_listbox.curselection()
        if not selection:
            return
        idx = selection[0]

        is_valid, cleaned_interval = validate_interval(self.interval_var.get())
        if not is_valid:
            messagebox.showerror(
                "Invalid Interval",
                "The interval must be a whole number between 1 and 2000."
            )
            return

        self.selected_scripts[idx]['primary_low'] = normalize_decimal_string(self.primary_low_var.get())
        self.selected_scripts[idx]['primary_high'] = normalize_decimal_string(self.primary_high_var.get())
        self.selected_scripts[idx]['duration'] = normalize_decimal_string(self.duration_var.get())
        self.selected_scripts[idx]['interval'] = cleaned_interval
        
        self.primary_low_var.set(self.selected_scripts[idx]['primary_low'])
        self.primary_high_var.set(self.selected_scripts[idx]['primary_high'])
        self.duration_var.set(self.selected_scripts[idx]['duration'])
        self.interval_var.set(self.selected_scripts[idx]['interval'])
        
        print(f"Details for '{self.selected_scripts[idx]['name']}' updated silently.")

class ProgramManager(tk.Tk):
    """The main application window."""
    def __init__(self):
        super().__init__()
        self.title("Program Manager")
        self.geometry("500x400")
        self.center_window()
        self.programs = self.load_programs()
        self.stop_flag = threading.Event()
        self.running_thread = None

        self.listbox = tk.Listbox(self, font=FONT_STYLE)
        self.listbox.pack(fill=tk.BOTH, expand=True)
        self.update_listbox()

        button_frame = tk.Frame(self)
        button_frame.pack(fill=tk.X)
        tk.Button(button_frame, text="Add", font=FONT_STYLE, command=self.add_program).pack(side=tk.LEFT, expand=True)
        tk.Button(button_frame, text="Edit", font=FONT_STYLE, command=self.edit_program).pack(side=tk.LEFT, expand=True)
        tk.Button(button_frame, text="Delete", font=FONT_STYLE, command=self.delete_program).pack(side=tk.LEFT, expand=True)
        tk.Button(button_frame, text="Start", font=FONT_STYLE, command=self.start_program).pack(side=tk.LEFT, expand=True)
        tk.Button(button_frame, text="Stop", font=FONT_STYLE, command=self.stop_program).pack(side=tk.LEFT, expand=True)

    def center_window(self):
        self.update_idletasks()
        width = self.winfo_width()
        height = self.winfo_height()
        x = (self.winfo_screenwidth() // 2) - (width // 2)
        y = (self.winfo_screenheight() // 2) - (height // 2)
        self.geometry(f"{width}x{height}+{x}+{y}")
        
    def edit_program(self):
        idx = self.listbox.curselection()
        if not idx:
            return
        program = self.programs[idx[0]]
        AddProgramWindow(self, edit_mode=True, program_data=program, program_index=idx[0])

    def correct_interval_on_load(self, interval_str):
        """If an interval from the file is a decimal or invalid, resets it to '1'."""
        try:
            val = float(interval_str)
            if val != int(val):
                return "1"
            return str(int(val))
        except (ValueError, TypeError):
            return "1"

    def load_programs(self):
        if not os.path.exists(SAVE_FILE):
            return []
        
        try:
            with open(SAVE_FILE, "r") as f:
                programs_data = json.load(f)
            
            data_was_changed = False
            for program in programs_data:
                for step in program.get("steps", []):
                    if 'interval' in step:
                        original_interval = step['interval']
                        corrected_interval = self.correct_interval_on_load(original_interval)
                        if original_interval != corrected_interval:
                            step['interval'] = corrected_interval
                            data_was_changed = True
                    
                    fields_to_normalize = ['primary_low', 'primary_high', 'duration']
                    for field in fields_to_normalize:
                        if field in step:
                            original_value = step[field]
                            corrected_value = normalize_decimal_string(original_value)
                            if original_value != corrected_value:
                                step[field] = corrected_value
                                data_was_changed = True
            
            if data_was_changed:
                print("[Load] Corrected invalid data from save file and re-saved.")
                self.save_programs(programs_data)

            return programs_data

        except json.JSONDecodeError:
            messagebox.showerror("Load Error", "Could not read save file. It may be corrupted.")
            return []
        except Exception as e:
            messagebox.showerror("Error", f"An unexpected error occurred while loading programs: {e}")
            return []

    def save_programs(self, data_to_save=None):
        """Saves the program list to the JSON file."""
        if data_to_save is None:
            data_to_save = self.programs
        with open(SAVE_FILE, "w") as f:
            json.dump(data_to_save, f, indent=2)

    def update_listbox(self):
        self.listbox.delete(0, tk.END)
        for prog in self.programs:
            self.listbox.insert(tk.END, prog['name'])

    def add_program(self):
        AddProgramWindow(self)

    def delete_program(self):
        idx = self.listbox.curselection()
        if not idx:
            return
        if messagebox.askyesno("Confirm Delete", f"Are you sure you want to delete '{self.programs[idx[0]]['name']}'?"):
            del self.programs[idx[0]]
            self.save_programs()
            self.update_listbox()

    def run_cleanup(self):
        """Kills all potentially running script processes."""
        print("[Cleanup] Running sudo pkill commands")
        # FIX: Corrected typo "adf4is a" to "adf4351"
        targets = ["start", "sa", "10k", "adf4351", "RAND", "sleep", "1020", "dtra", "t1", "t2", "dtmenu"]
        for name in targets:
            try:
                subprocess.run(["sudo", "/usr/bin/pkill", "-f", name], check=False, capture_output=True)
                print(f"[Cleanup] Sent kill signal for processes matching: {name}")
            except Exception as e:
                print(f"[Cleanup] Error trying to kill process {name}: {e}")

    def start_program(self):
        if self.running_thread and self.running_thread.is_alive():
            messagebox.showwarning("Warning", "A program is already running. Please stop it first.")
            return
            
        idx = self.listbox.curselection()
        if not idx:
            return

        program = self.programs[idx[0]]
        self.stop_flag.clear()

        def run():
            try:
                subprocess.Popen(["/home/pi/Desktop/testmodules/adf4351"])
                for i in range(2, 10):
                    subprocess.Popen([f"/home/pi/Desktop/testmodules/adf4351{i}"])
            except FileNotFoundError as e:
                print(f"[Runner] Error starting adf4351 processes: {e}")

            while not self.stop_flag.is_set():
                for step in program['steps']:
                    if self.stop_flag.is_set():
                        break

                    print(f"[Runner] Cleaning up before step: {step['name']}")
                    self.run_cleanup()

                    try:
                        subprocess.run(["sudo", "rm", "-f", "/tmp/ramdisk/SG3.TXT"], check=True)
                        print("[Runner] Deleted /tmp/ramdisk/SG3.TXT")
                    except (subprocess.CalledProcessError, FileNotFoundError) as e:
                        print(f"[Runner] Could not delete SG3.TXT: {e}")

                    interval = step.get('interval', '1')
                    low = step.get('primary_low', '35')
                    high = step.get('primary_high', '4400')

                    is_valid, clean_interval = validate_interval(interval)
                    if not is_valid:
                        print(f"[Runner] SKIPPING step '{step['name']}' due to invalid interval '{interval}'.")
                        continue

                    if clean_interval != '1':
                        args = ["sudo", "/home/pi/Desktop/loadrd", low, high, clean_interval]
                        subprocess.run(args)
                    else:
                        subprocess.run(["bash", "/home/pi/Desktop/loadrd.sh", low, high])
                    
                    print(f"[Runner] Running script: {step['script']}")
                    subprocess.run(step['script'], shell=True)
                    
                    try:
                        duration_minutes = float(step.get('duration', '1'))
                    except ValueError:
                        print(f"[Runner] Invalid duration value: {step.get('duration')}. Defaulting to 1 minute.")
                        duration_minutes = 1.0

                    total_seconds = int(duration_minutes * 60)
                    end_time = time.time() + total_seconds
                    
                    while time.time() < end_time:
                        if self.stop_flag.wait(timeout=1):
                           break
                    
                if not program.get('loop', False):
                    break
            
            print("[Runner] Program finished.")
            self.run_cleanup()

        self.running_thread = threading.Thread(target=run, daemon=True)
        self.running_thread.start()

    def stop_program(self):
        print("Stop button pressed")
        self.stop_flag.set()
        if self.running_thread:
            self.running_thread.join(timeout=2.0)
        self.run_cleanup()
        print("All running programs have been stopped.")

if __name__ == "__main__":
    app = ProgramManager()
    app.mainloop()
