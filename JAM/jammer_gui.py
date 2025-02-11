#!/usr/bin/env python3
"""
jammer_gui.py

GUI to control multiple jamming modules, each on its own tab.
Now includes:
  - Start All / Stop All buttons in the top bar.
  - Save State / Load State buttons to export/import module settings.
  - 'pam' added to the Modulation combobox (from previous example).

Requires each jamming module binary in the same directory or in PATH.
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
        self.geometry("900x650")  # Adjust as needed

        # 1) Top frame for global controls (Start All, Stop All, Save, Load)
        top_frame = ttk.Frame(self)
        top_frame.pack(side="top", fill="x", padx=5, pady=5)

        # a) Start All
        start_all_btn = ttk.Button(top_frame, text="Start All", command=self.start_all_modules)
        start_all_btn.pack(side="left", padx=(0, 5))

        # b) Stop All
        stop_all_btn = ttk.Button(top_frame, text="Stop All", command=self.stop_all_modules)
        stop_all_btn.pack(side="left", padx=(0, 20))

        # c) Save State
        save_btn = ttk.Button(top_frame, text="Save State", command=self.save_state_to_file)
        save_btn.pack(side="left", padx=(0, 5))

        # d) Load State
        load_btn = ttk.Button(top_frame, text="Load State", command=self.load_state_from_file)
        load_btn.pack(side="left")

        # 2) Notebook for multiple modules
        self.notebook = ttk.Notebook(self)
        self.notebook.pack(fill="both", expand=True)

        self.controllers = []
        self.module_frames = []  # Store references to each tab's tk variables

        for i, binary in enumerate(module_binaries):
            controller = JammerModuleController(binary)
            self.controllers.append(controller)

            # Create a frame (tab) for this module
            tab_frame = ttk.Frame(self.notebook)
            self.notebook.add(tab_frame, text=f"Module {i+1}")

            # Build the UI and store its variables
            vars_dict = self.build_module_ui(tab_frame, i, binary)
            self.module_frames.append(vars_dict)

    def build_module_ui(self, parent, index, binary):
        """
        Create controls on the tab for module <index>.
        Returns a dict of the tkinter variables (for saving/loading and Start All).
        """
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

        # Sweep Controls
        ttk.Label(parent, text="Sweep Start (MHz):").grid(row=5, column=0, padx=5, pady=5, sticky="e")
        sweep_start_var = tk.StringVar(value="900.0")
        ttk.Entry(parent, textvariable=sweep_start_var, width=10).grid(row=5, column=1, padx=5, pady=5)

        ttk.Label(parent, text="Sweep End (MHz):").grid(row=6, column=0, padx=5, pady=5, sticky="e")
        sweep_end_var = tk.StringVar(value="1000.0")
        ttk.Entry(parent, textvariable=sweep_end_var, width=10).grid(row=6, column=1, padx=5, pady=5)

        ttk.Label(parent, text="Sweep Step (MHz):").grid(row=7, column=0, padx=5, pady=5, sticky="e")
        sweep_step_var = tk.StringVar(value="1.0")
        ttk.Entry(parent, textvariable=sweep_step_var, width=10).grid(row=7, column=1, padx=5, pady=5)

        ttk.Label(parent, text="Dwell (ms):").grid(row=8, column=0, padx=5, pady=5, sticky="e")
        sweep_dwell_var = tk.StringVar(value="100")
        ttk.Entry(parent, textvariable=sweep_dwell_var, width=10).grid(row=8, column=1, padx=5, pady=5)

        # Sweep Direction
        ttk.Label(parent, text="Sweep Dir:").grid(row=9, column=0, padx=5, pady=5, sticky="e")
        sweep_dir_var = tk.StringVar(value="forward")
        ttk.Combobox(
            parent, textvariable=sweep_dir_var,
            values=["forward", "backward"], width=10
        ).grid(row=9, column=1, padx=5, pady=5)

        # Modulation (including 'pam')
        ttk.Label(parent, text="Modulation:").grid(row=10, column=0, padx=5, pady=5, sticky="e")
        mod_var = tk.StringVar(value="off")
        ttk.Combobox(
            parent, textvariable=mod_var,
            values=["off", "am", "fm", "qam", "pam"], width=10
        ).grid(row=10, column=1, padx=5, pady=5)

        # Start/Stop/Off buttons
        start_btn = ttk.Button(
            parent, text="Start",
            command=lambda: self.start_module(index)
        )
        start_btn.grid(row=11, column=0, padx=5, pady=5, sticky="e")

        stop_btn = ttk.Button(
            parent, text="Stop",
            command=lambda: self.stop_module(index)
        )
        stop_btn.grid(row=11, column=1, padx=5, pady=5, sticky="w")

        off_btn = ttk.Button(
            parent, text="Off",
            command=lambda: self.off_module(index)
        )
        off_btn.grid(row=12, column=0, columnspan=2, padx=5, pady=5, sticky="ew")

        parent.grid_columnconfigure(1, weight=1)

        # Return references
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

    def get_cmd_args_for_module(self, idx):
        """
        Build the command line arguments for module <idx> based on current GUI values.
        """
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

    # ----------------------
    # Start/Stop/Off Single Module
    # ----------------------
    def start_module(self, idx):
        """Start a single module process based on current GUI values."""
        cmd_args = self.get_cmd_args_for_module(idx)
        self.controllers[idx].start(cmd_args)

    def stop_module(self, idx):
        """Stop the module's running process."""
        self.controllers[idx].stop()

    def off_module(self, idx):
        """Send --off to power down hardware, then optionally stop afterward."""
        self.controllers[idx].stop()
        self.controllers[idx].start(["--off"])
        # optionally kill the process after a short delay:
        # self.after(500, lambda: self.controllers[idx].stop())

    # ----------------------
    # Start All / Stop All
    # ----------------------
    def start_all_modules(self):
        """Gather settings for each module and start all in sequence."""
        for i in range(len(self.controllers)):
            cmd_args = self.get_cmd_args_for_module(i)
            # Stop first to ensure clean start
            self.controllers[i].stop()
            self.controllers[i].start(cmd_args)

    def stop_all_modules(self):
        """Stop every module."""
        for i in range(len(self.controllers)):
            self.stop_module(i)

    # ----------------------
    # Save/Load State
    # ----------------------
    def save_state_to_file(self):
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
        file_path = filedialog.askopenfilename(
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

        # all_data should be a list of dicts, one per module
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
    # Example: 9 module binaries
    module_binaries = [
        "./adf4351",
        "./adf43512",
        "./adf43513",
        "./adf43514",
        "./adf43515",
        "./adf43516",
        "./adf43517",
        "./adf43518",
        "./adf43519"
    ]
    app = JammerGUI(module_binaries)
    app.mainloop()
