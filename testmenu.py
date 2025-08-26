import tkinter as tk
from tkinter import simpledialog, messagebox
import subprocess
import json
import os
import threading

SAVE_FILE = "/home/pi/Desktop/saved_programs.json"

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
    "Full Burst": "bash /home/pi/Desktop/sa6.sh&"
    "Pain Mode": "bash /home/pi/Desktop/startDLPFC2.sh&"
}

FONT_STYLE = ("TkDefaultFont", 12)

class KeypadWindow(tk.Toplevel):
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
            
            # Ensure all required keys exist
            for step in self.selected_scripts:
                step.setdefault("primary_low", "35")
                step.setdefault("primary_high", "4400")
                step.setdefault("duration", "1")

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
    
    def normalize_duration(self, value):
        if value.startswith("."):
            return "0" + value
        return value
    
    def save_program(self):
        name = self.name_entry.get().strip()
        if not name:
            messagebox.showerror("Error", "Program must have a name")
            return

        program = {
            "name": name,
            "loop": self.loop_var.get(),
            "steps": self.selected_scripts
        }

        if self.edit_mode and self.program_index is not None:
            self.master.programs[self.program_index] = program
        else:
            self.master.programs.append(program)
            
        for s in self.selected_scripts:
            s['duration'] = self.normalize_duration(s['duration'])
            s['interval'] = s.get('interval', '1')

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
        self.primary_low_var.set(s['primary_low'])
        self.primary_high_var.set(s['primary_high'])
        self.duration_var.set(s['duration'])
        self.interval_var.set(s.get('interval', '1'))


    def update_script_details(self):
        selection = self.selected_listbox.curselection()
        if not selection:
            return
        self.selected_scripts[selection[0]]['primary_low'] = self.primary_low_var.get()
        self.selected_scripts[selection[0]]['primary_high'] = self.primary_high_var.get()
        normalized = self.normalize_duration(self.duration_var.get())
        self.duration_var.set(normalized)
        self.selected_scripts[selection[0]]['duration'] = normalized
        self.selected_scripts[selection[0]]['interval'] = self.interval_var.get()



    def save_program(self):
        name = self.name_entry.get().strip()
        if not name:
            messagebox.showerror("Error", "Program must have a name")
            return
        program = {
            "name": name,
            "loop": self.loop_var.get(),
            "steps": self.selected_scripts
        }
        self.master.programs.append(program)
        self.master.save_programs()
        self.master.update_listbox()
        self.destroy()

class ProgramManager(tk.Tk):
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

    def load_programs(self):
        if os.path.exists(SAVE_FILE):
            with open(SAVE_FILE, "r") as f:
                return json.load(f)
        return []

    def save_programs(self):
        with open(SAVE_FILE, "w") as f:
            json.dump(self.programs, f, indent=2)

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
        del self.programs[idx[0]]
        self.save_programs()
        self.update_listbox()

    def run_cleanup(self):
        print("[Cleanup] Running sudo pkill commands")
        targets = ["start", "sa", "10k", "adf4351", "RAND", "sleep", "1020", "dtra", "t1", "t2", "dtmenu"]
        for name in targets:
            try:
                print(f"[Cleanup] Attempting: sudo pkill -f {name}")
                result = subprocess.run(["sudo", "/usr/bin/pkill", "-f", name], check=True)
                print(f"[Cleanup] Killed: {name}")
            except subprocess.CalledProcessError:
                print(f"[Cleanup] No process or error for: {name}")




    def start_program(self):
        idx = self.listbox.curselection()
        if not idx:
            return

        program = self.programs[idx[0]]
        self.stop_flag.clear()

        def run():
            subprocess.Popen(["/home/pi/Desktop/testmodules/adf4351"])
            for i in range(2, 10):
                subprocess.Popen([f"/home/pi/Desktop/testmodules/adf4351{i}"])

            while not self.stop_flag.is_set():
                for step in program['steps']:
                    if self.stop_flag.is_set():
                        break

                    print(f"[Runner] Cleaning up before step: {step['name']}")
                    self.run_cleanup()  # <-- Kill old scripts BEFORE starting next

                  



                    if step.get('interval', '1') != '1':
                              # Delete SG3.TXT before running loadrd
                        try:
                            subprocess.call(["sudo", "rm", "-f", "/tmp/ramdisk/SG3.TXT"])
                            print("[Runner] Deleted /tmp/ramdisk/SG3.TXT")
                        except Exception as e:
                            print(f"[Runner] Failed to delete SG3.TXT: {e}")
                            
                        args = ["sudo", "/home/pi/Desktop/loadrd", step['primary_low'], step['primary_high']]
                        if step.get('interval', '1') != '1':
                            args.append(step['interval'])
                        subprocess.call(args)

                    else:
                                                      # Delete SG3.TXT before running loadrd
                        try:
                            subprocess.call(["sudo", "rm", "-f", "/tmp/ramdisk/SG3.TXT"])
                            print("[Runner] Deleted /tmp/ramdisk/SG3.TXT")
                        except Exception as e:
                            print(f"[Runner] Failed to delete SG3.TXT: {e}")
                            

                        subprocess.call(["bash", "/home/pi/Desktop/loadrd.sh", step['primary_low'], step['primary_high']])

                    
                    print(f"[Runner] Running script: {step['script']}")
                    subprocess.call(step['script'], shell=True)
                    try:
                        duration_minutes = float(step['duration'])
                    except ValueError:
                        print(f"[Runner] Invalid duration value: {step['duration']}. Skipping step.")
                        continue

                    total_seconds = int(duration_minutes * 60)
                    interval = 10  # seconds per wait
                    loops = total_seconds // interval
                    remainder = total_seconds % interval

                    for _ in range(loops):
                        if self.stop_flag.is_set():
                            break
                        threading.Event().wait(interval)

                    if not self.stop_flag.is_set() and remainder > 0:
                        threading.Event().wait(remainder)

                if not program.get('loop'):
                    break

        self.running_thread = threading.Thread(target=run, daemon=True)
        self.running_thread.start()

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

    def load_programs(self):
        if os.path.exists(SAVE_FILE):
            with open(SAVE_FILE, "r") as f:
                return json.load(f)
        return []

    def save_programs(self):
        with open(SAVE_FILE, "w") as f:
            json.dump(self.programs, f, indent=2)

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
        del self.programs[idx[0]]
        self.save_programs()
        self.update_listbox()

    def stop_program(self):
        print("Stop button pressed")
        self.stop_flag.set()
        self.run_cleanup()



    def start_program(self):
        idx = self.listbox.curselection()
        if not idx:
            return

        program = self.programs[idx[0]]
        self.stop_flag.clear()

        def run():
            subprocess.Popen(["/home/pi/Desktop/testmodules/adf4351"])
            for i in range(2, 10):
                subprocess.Popen([f"/home/pi/Desktop/testmodules/adf4351{i}"])

            while not self.stop_flag.is_set():
                for step in program['steps']:
                    if self.stop_flag.is_set():
                        break
                    print("[Cleanup] Running sudo pkill commands")
                    targets = ["start", "sa", "10k", "adf4351", "RAND", "sleep", "1020", "dtra", "t1", "t2", "dtmenu"]
                    for name in targets:
                        try:
                            print(f"[Cleanup] Attempting: sudo pkill -f {name}")
                            result = subprocess.run(["sudo", "/usr/bin/pkill", "-f", name], check=True)
                            print(f"[Cleanup] Killed: {name}")
                        except subprocess.CalledProcessError:
                            print(f"[Cleanup] No process or error for: {name}")



                    interval = step.get('interval', '1')
                    if interval != '1':
                        try:
                            subprocess.call(["sudo", "rm", "-f", "/tmp/ramdisk/SG3.TXT"])
                            print("[Runner] Deleted /tmp/ramdisk/SG3.TXT")
                        except Exception as e:
                            print(f"[Runner] Failed to delete SG3.TXT: {e}")
                        args = ["sudo", "/home/pi/Desktop/loadrd", step['primary_low'], step['primary_high']]
                        if step.get('interval', '1') != '1':
                            try:
                                subprocess.call(["sudo", "rm", "-f", "/tmp/ramdisk/SG3.TXT"])
                                print("[Runner] Deleted /tmp/ramdisk/SG3.TXT")
                            except Exception as e:
                                print(f"[Runner] Failed to delete SG3.TXT: {e}")
                            args.append(step['interval'])
                        subprocess.call(args)

                    else:
                        subprocess.call(["bash", "/home/pi/Desktop/loadrd.sh", step['primary_low'], step['primary_high']])
                    
                    subprocess.call(step['script'], shell=True)
                    try:
                        duration_minutes = float(step['duration'])
                    except ValueError:
                        print(f"[Runner] Invalid duration value: {step['duration']}. Skipping step.")
                        continue

                    total_seconds = int(duration_minutes * 60)
                    interval = 10  # seconds per wait
                    loops = total_seconds // interval
                    remainder = total_seconds % interval

                    for _ in range(loops):
                        if self.stop_flag.is_set():
                            break
                        threading.Event().wait(interval)

                    if not self.stop_flag.is_set() and remainder > 0:
                        threading.Event().wait(remainder)

                if not program.get('loop'):
                    break

        self.running_thread = threading.Thread(target=run, daemon=True)
        self.running_thread.start()

if __name__ == "__main__":
    app = ProgramManager()
    app.mainloop()
