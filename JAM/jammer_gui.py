#!/usr/bin/env python3
"""
jammer_gui.py

A tabbed GUI to control multiple jamming modules.
Features:
  - Start/Stop/Off per module
  - Start All / Stop All buttons (global)
  - Save State / Load State to/from a JSON file
  - Hard-coded module binaries in /home/pi/Desktop/JAM
  - File dialogs (Save/Load) start in /home/pi/Desktop/JAM
  - Supports "pam" modulation in addition to off/am/fm/qam
"""

import tkinter as tk
from tkinter import ttk, filedialog
import subprocess
import json
import os

class JammerModuleController:
    def __init__(self, binary_path):
        self.binary_path = binary_path
        self.process = None

    def start(self, cmd_args):
        """Stop any existing process, then start a new one with cmd_args."""
        self.stop()
        full_cmd = [self.binary_path] + cmd_args
        print(f"Starting {full_cmd}")
        try:
            self.process = subprocess.Popen(full_cmd)
        except Exception as e:
            print(f"Error starting {self.binary_path}: {e}")

    def stop(self):
        """Terminate the running process if it exists."""
        if self.process and self.process.poll() is None:
            print(f"Stopping {self.binary_path} [PID={self.process.pid}]...")
            self.process.terminate()
            try:
                self.process.wait(timeout=2)
            except subprocess.TimeoutExpired:
                self.process.kill()
        self.process = None

class JammerGUI(tk.Tk):
    def __init__(self, module_binaries):
        super().__init__()
        self.title("Multi-Module Jammer Control (Tabbed)")
        self.geometry("900x650")  # Adjust window size as needed

        # Top Frame for global controls
        top_frame = ttk.Frame(self)
        top_frame.pack(side="top", fill="x", padx=5, pady=5)

        # "Start All" / "Stop All"
        start_all_btn = ttk.Button(top_frame, text="Start All", command=self.start_all_modules)
        start_all_btn.pack(side="left", padx=(0, 5))

        stop_all_btn = ttk.Button(top_frame, text="Stop All", command=self.stop_all_modules)
        stop_all_btn.pack(side="left", padx=(0, 20))

        # "Save State" / "Load State"
        save_btn = ttk.Button(top_frame, text="Save State", command=self.save_state_to_file)
        save_btn.pack(side="left", padx=(0, 5))

        load_btn = ttk.Button(top_frame, text="Load State", command=self.load_state_from_file)
        load_btn.pack(side="left")

        # Notebook for each module
        self.notebook = ttk.Notebook(self)
        self.notebook.pack(fill="both", expand=True)

        self.controllers = []
        self.module_frames = []

        # Create one tab per module
        for i, binary in enumerate(module_binaries):
            controller = JammerModuleController(binary)
            self.controllers.append(controller)

            tab_frame = ttk.Frame(self.notebook)
            self.notebook.add(tab_frame, text=f"Module {i+1}")

            vars_dict = self.build_module_ui(tab_frame, i, binary)
            self.module_frames.append(vars_dict)

        # The path where we store our JSON (and possibly load from)
        self.initial_path = "/home/pi/Desktop/JAM"

    def build_module_ui(self, parent, index, binary):
        """
        Returns a dict of the tk variables for saving/loading and for building cmd args.
        """
        # Show the binary path
        bin_label = ttk.Label(parent, text=f"Binary: {binary}")
        bin_label.grid(row=0, column=0, columnspan=2, pady=(10,5), padx=5, sticky="w")

        # Frequency
        ttk.Label(parent, text="Frequency (MHz):").grid(row=1, column=0, padx=5, pady=5, sticky="e")
        freq_var = tk.StringVar(value="1000.0")
        ttk.Entry(parent, textvariable=freq_var, width=10).grid(row=1, column=1, padx=5, pady=5)

        # Reference Frequency
        ttk.Label(parent, text="Ref (Hz):").grid(row=2, column=0, padx=5, pady=5, sticky="e")
        ref_var = tk.StringVar(value="25000000")
        ttk.Entry(parent, textvariable=ref_var, width=10).grid(row=2, column=1, padx=5, pady=5)

        # Power
        ttk.Label(parent, text="Power (0..3):").grid(row=3, column=0, padx=5, pady=5, sticky="e")
        power_var = tk.StringVar(value="3")
        ttk.Entry(parent, textvariable=power_var, width=5).grid(row=3, column=1, padx=5, pady=5)

        # Mode
        ttk.Label(parent, text="Mode:").grid(row=4, column=0, padx=5, pady=5, sticky="e")
        mode_var = tk.StringVar(value="fixed")
        mode_combo = ttk.Combobox(
            parent, textvariable=mode_var,
            values=["fixed", "sweep", "custom"], width=10
        )
        mode_combo.grid(row=4, column=1, padx=5, pady=5)

        # Sweep Start
        ttk.Label(parent, text="Sweep Start (MHz):").grid(row=5, column=0, padx=5, pady=5, sticky="e")
        sweep_start_var = tk.StringVar(value="900.0")
        ttk.Entry(parent, textvariable=sweep_start_var, width=10).grid(row=5, column=1, padx=5, pady=5)

        # Sweep End
        ttk.Label(parent, text="Sweep End (MHz):").grid(row=6, column=0, padx=5, pady=5, sticky="e")
        sweep_end_var = tk.StringVar(value="1000.0")
        ttk.Entry(parent, textvariable=sweep_end_var, width=10).grid(row=6, column=1, padx=5, pady=5)

        # Sweep Step
        ttk.Label(parent, text="Sweep Step (MHz):").grid(row=7, column=0, padx=5, pady=5, sticky="e")
        sweep_step_var = tk.StringVar(value="1.0")
        ttk.Entry(parent, textvariable=sweep_step_var, width=10).grid(row=7, column=1, padx=5, pady=5)

        # Dwell
        ttk.Label(parent, text="Dwell (ms):").grid(row=8, column=0, padx=5, pady=5, sticky="e")
        sweep_dwell_var = tk.StringVar(value="100")
        ttk.Entry(parent, textvariable=sweep_dwell_var, width=10).grid(row=8, column=1, padx=5, pady=5)

        # Direction
        ttk.Label(parent, text="Sweep Dir:").grid(row=9, column=0, padx=5, pady=5, sticky="e")
        sweep_dir_var = tk.StringVar(value="forward")
        ttk.Combobox(
            parent, textvariable=sweep_dir_var,
            values=["forward", "backward"], width=10
        ).grid(row=9, column=1, padx=5, pady=5)

        # Modulation (includes "pam")
        ttk.Label(parent, text="Modulation:").grid(row=10, column=0, padx=5, pady=5, sticky="e")
        mod_var = tk.StringVar(value="off")
        ttk.Combobox(
            parent, textvariable=mod_var,
            values=["off", "am", "fm", "qam", "pam"], width=10
        ).grid(row=10, column=1, padx=5, pady=5)

        # Buttons
        start_btn = ttk.Button(parent, text="Start", command=lambda: self.start_module(index))
        start_btn.grid(row=11, column=0, padx=5, pady=5, sticky="e")

        stop_btn = ttk.Button(parent, text="Stop", command=lambda: self.stop_module(index))
        stop_btn.grid(row=11, column=1, padx=5, pady=5, sticky="w")

        off_btn = ttk.Button(parent, text="Off", command=lambda: self.off_module(index))
        off_btn.grid(row=12, column=0, columnspan=2, padx=5, pady=5, sticky="ew")

        parent.grid_columnconfigure(1, weight=1)

        return {
            "freq_var": freq_var,
            "ref_var": ref_var,
            "power_var": power_var,
            "mode_var": mode_var,
            "sweep_start_var": sweep_start_var,
            "sweep_end_var": sweep_end_var,
            "sweep_step_var": sweep_step_var,
            "sweep_dwell_var": sweep_dwell_var,
            "sweep_dir_var": sweep_dir_var,
            "mod_var": mod_var
        }

    # ----------------------------
    # Command Arg Builder
    # ----------------------------
    def get_cmd_args_for_module(self, idx):
        vars_dict = self.module_frames[idx]
        freq  = vars_dict["freq_var"].get()
        ref   = vars_dict["ref_var"].get()
        pwr   = vars_dict["power_var"].get()
        mode  = vars_dict["mode_var"].get()
        start = vars_dict["sweep_start_var"].get()
        end   = vars_dict["sweep_end_var"].get()
        step  = vars_dict["sweep_step_var"].get()
        dwell = vars_dict["sweep_dwell_var"].get()
        direc = vars_dict["sweep_dir_var"].get()
        mod   = vars_dict["mod_var"].get()

        if mode == "fixed":
            cmd_args = [
                "--mode", "fixed",
                "--freq",  freq,
                "--ref",   ref,
                "--power", pwr,
                "--dir",   direc,
                "--mod",   mod
            ]
        elif mode == "sweep":
            cmd_args = [
                "--mode",  "sweep",
                "--start", start,
                "--end",   end,
                "--step",  step,
                "--dwell", dwell,
                "--ref",   ref,
                "--power", pwr,
                "--dir",   direc,
                "--mod",   mod
            ]
        else:  # custom
            cmd_args = [
                "--mode",  "custom",
                "--freq",  freq,
                "--ref",   ref,
                "--power", pwr,
                "--dir",   direc,
                "--mod",   mod
            ]
        return cmd_args

    # ----------------------------
    # Single Module Control
    # ----------------------------
    def start_module(self, idx):
        cmd_args = self.get_cmd_args_for_module(idx)
        self.controllers[idx].start(cmd_args)

    def stop_module(self, idx):
        self.controllers[idx].stop()

    def off_module(self, idx):
        self.controllers[idx].stop()
        self.controllers[idx].start(["--off"])
        # optionally kill the process after a short delay:
        # self.after(500, lambda: self.controllers[idx].stop())

    # ----------------------------
    # Start/Stop All
    # ----------------------------
    def start_all_modules(self):
        for i in range(len(self.controllers)):
            cmd_args = self.get_cmd_args_for_module(i)
            self.controllers[i].stop()
            self.controllers[i].start(cmd_args)

    def stop_all_modules(self):
        for i in range(len(self.controllers)):
            self.stop_module(i)

    # ----------------------------
    # Save/Load State
    # ----------------------------
    def save_state_to_file(self):
        """
        Saves the current settings of all modules as a JSON array of dicts.
        The file dialog starts in /home/pi/Desktop/JAM.
        """
        all_data = []
        for i, vars_dict in enumerate(self.module_frames):
            mod_data = {
                "freq":        vars_dict["freq_var"].get(),
                "ref":         vars_dict["ref_var"].get(),
                "power":       vars_dict["power_var"].get(),
                "mode":        vars_dict["mode_var"].get(),
                "sweep_start": vars_dict["sweep_start_var"].get(),
                "sweep_end":   vars_dict["sweep_end_var"].get(),
                "sweep_step":  vars_dict["sweep_step_var"].get(),
                "sweep_dwell": vars_dict["sweep_dwell_var"].get(),
                "sweep_dir":   vars_dict["sweep_dir_var"].get(),
                "mod":         vars_dict["mod_var"].get()
            }
            all_data.append(mod_data)

        file_path = filedialog.asksaveasfilename(
            initialdir=self.initial_path,
            defaultextension=".json",
            filetypes=[("JSON Files", "*.json"), ("All Files", "*.*")]
        )
        if not file_path:
            return  # user canceled

        try:
            with open(file_path, "w") as f:
                json.dump(all_data, f, indent=2)
            print(f"Settings saved to {file_path}")
        except Exception as e:
            print(f"Error saving settings: {e}")

    def load_state_from_file(self):
        """
        Loads module settings from a JSON file.
        The file dialog starts in /home/pi/Desktop/JAM.
        """
        file_path = filedialog.askopenfilename(
            initialdir=self.initial_path,
            defaultextension=".json",
            filetypes=[("JSON Files", "*.json"), ("All Files", "*.*")]
        )
        if not file_path or not os.path.isfile(file_path):
            return

        try:
            with open(file_path, "r") as f:
                all_data = json.load(f)
        except Exception as e:
            print(f"Error loading file: {e}")
            return

        if not isinstance(all_data, list) or len(all_data) != len(self.module_frames):
            print("Error: loaded data does not match number of modules.")
            return

        # Update each module's UI
        for i, vars_dict in enumerate(self.module_frames):
            mod_data = all_data[i]
            vars_dict["freq_var"].set(mod_data["freq"])
            vars_dict["ref_var"].set(mod_data["ref"])
            vars_dict["power_var"].set(mod_data["power"])
            vars_dict["mode_var"].set(mod_data["mode"])
            vars_dict["sweep_start_var"].set(mod_data["sweep_start"])
            vars_dict["sweep_end_var"].set(mod_data["sweep_end"])
            vars_dict["sweep_step_var"].set(mod_data["sweep_step"])
            vars_dict["sweep_dwell_var"].set(mod_data["sweep_dwell"])
            vars_dict["sweep_dir_var"].set(mod_data["sweep_dir"])
            vars_dict["mod_var"].set(mod_data["mod"])

        print(f"Settings loaded from {file_path}")


if __name__ == "__main__":
    # Hard-code the path for the module binaries
    BASE_PATH = "/home/pi/Desktop/JAM"

    module_binaries = [
        os.path.join(BASE_PATH, "adf4351"),
        os.path.join(BASE_PATH, "adf43512"),
        os.path.join(BASE_PATH, "adf43513"),
        os.path.join(BASE_PATH, "adf43514"),
        os.path.join(BASE_PATH, "adf43515"),
        os.path.join(BASE_PATH, "adf43516"),
        os.path.join(BASE_PATH, "adf43517"),
        os.path.join(BASE_PATH, "adf43518"),
        os.path.join(BASE_PATH, "adf43519"),
    ]

    app = JammerGUI(module_binaries)
    app.mainloop()
