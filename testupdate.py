#!/usr/bin/env python3

import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

import requests
import zipfile
import shutil
import os
import json
import threading
import subprocess
import time

os.chdir("/tmp")

# ================= CONFIG =================
OWNER = "druble81"
REPO = "cybershield"
INSTALL_DIR = "/home/pi/Desktop"
TMP_DIR = "/tmp"
UPDATE_LOG = "/home/pi/Desktop/updatelevel.json"

API_URL = f"https://api.github.com/repos/{OWNER}/{REPO}/releases"
TOKEN = os.getenv("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")
# ==========================================


def get_extraction_root(zip_path):
    with zipfile.ZipFile(zip_path, "r") as z:
        paths = z.namelist()
        if not paths:
            raise RuntimeError("Zip archive is empty")
        return os.path.commonpath(paths)


# ---------------- Update Log ----------------
def ensure_update_log_exists():
    if not os.path.exists(UPDATE_LOG):
        data = {
            "tag": "none",
            "installed_at": "never",
            "comments": ""
        }
        with open(UPDATE_LOG, "w") as f:
            json.dump(data, f, indent=2)
            f.flush()
            os.fsync(f.fileno())


def load_update_log():
    ensure_update_log_exists()
    try:
        with open(UPDATE_LOG, "r") as f:
            return json.load(f)
    except Exception:
        return {
            "tag": "unknown",
            "installed_at": "unknown",
            "comments": ""
        }


def save_update_log(release):
    data = {
        "tag": release.get("tag_name"),
        "installed_at": GLib.DateTime.new_now_utc().format_iso8601(),
        "comments": release.get("body", "").strip()
    }

    with open(UPDATE_LOG, "w") as f:
        json.dump(data, f, indent=2)
        f.flush()
        os.fsync(f.fileno())


class UpdaterGUI(Gtk.Window):
    def __init__(self):
        super().__init__(title="CyberShield Updater")
        self.set_border_width(10)
        self.set_default_size(520, 450)

        ensure_update_log_exists()

        self.vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(self.vbox)

        # -------- Installed info --------
        self.installed_label = Gtk.Label()
        self.installed_label.set_xalign(0)
        self.installed_label.set_line_wrap(True)
        self.vbox.pack_start(self.installed_label, False, False, 0)

        # -------- Release list --------
        self.liststore = Gtk.ListStore(str, str)
        self.tree = Gtk.TreeView(model=self.liststore)

        for i, title in enumerate(["Tag", "Published"]):
            renderer = Gtk.CellRendererText()
            col = Gtk.TreeViewColumn(title, renderer, text=i)
            self.tree.append_column(col)

        self.vbox.pack_start(self.tree, True, True, 0)

        # -------- Status --------
        self.status = Gtk.Label(label="Idle")
        self.status.set_xalign(0)
        self.vbox.pack_start(self.status, False, False, 0)

        # -------- Buttons --------
        btn_box = Gtk.Box(spacing=6)
        self.vbox.pack_start(btn_box, False, False, 0)

        self.refresh_btn = Gtk.Button(label="Check for Updates")
        self.refresh_btn.connect("clicked", self.refresh)
        btn_box.pack_start(self.refresh_btn, True, True, 0)

        self.install_btn = Gtk.Button(label="Install Selected")
        self.install_btn.connect("clicked", self.install_selected)
        btn_box.pack_start(self.install_btn, True, True, 0)

        self.releases = []
        self.update_installed_display()
        self.refresh(None)

    # ---------------- GitHub ----------------
    def fetch_releases(self):
        headers = {"Accept": "application/vnd.github+json"}
        if TOKEN:
            headers["Authorization"] = f"Bearer {TOKEN}"

        r = requests.get(API_URL, headers=headers)
        r.raise_for_status()
        return r.json()

    # ---------------- GUI ----------------
    def refresh(self, _):
        self.status.set_text("Checking GitHub…")
        threading.Thread(target=self._refresh_thread, daemon=True).start()

    def _refresh_thread(self):
        try:
            self.releases = self.fetch_releases()
            GLib.idle_add(self.populate_list)
            GLib.idle_add(self.status.set_text, f"{len(self.releases)} release(s) found")
        except Exception as e:
            GLib.idle_add(self.status.set_text, f"Error: {e}")

    def populate_list(self):
        self.liststore.clear()
        for r in self.releases:
            self.liststore.append([r["tag_name"], r["published_at"]])

    def update_installed_display(self):
        log = load_update_log()

        text = (
            f"Installed: {log['tag']}\n"
            f"Installed at: {log['installed_at']}"
        )

        if log.get("comments"):
            text += f"\n\nRelease notes:\n{log['comments']}"

        self.installed_label.set_text(text)

    # ---------------- INSTALL ----------------
    def install_selected(self, _):
        sel = self.tree.get_selection()
        model, itr = sel.get_selected()
        if not itr:
            self.status.set_text("No release selected")
            return

        tag = model[itr][0]
        release = next(r for r in self.releases if r["tag_name"] == tag)

        threading.Thread(
            target=self.install_release,
            args=(release,),
            daemon=True
        ).start()

    def install_release(self, release):
        try:
            tag = release["tag_name"]
            zip_url = release["zipball_url"]

            zip_path = f"{TMP_DIR}/{tag}.zip"
            extract_dir = f"{TMP_DIR}/extract_{tag}"

            self.set_status(f"Downloading {tag}…")
            self.download(zip_url, zip_path)

            self.set_status("Extracting…")
            shutil.rmtree(extract_dir, ignore_errors=True)
            os.makedirs(extract_dir, exist_ok=True)

            with zipfile.ZipFile(zip_path, "r") as z:
                z.extractall(extract_dir)

            root = get_extraction_root(zip_path)
            root_path = os.path.join(extract_dir, root)

            self.set_status("Installing files…")
            self.copy_overwrite(root_path, INSTALL_DIR)

            self.set_status("Running post-install steps…")
            self.run_post_install()

            save_update_log(release)
            GLib.idle_add(self.update_installed_display)

            self.set_status("Syncing filesystem…")
            subprocess.run("sync", shell=True)
            time.sleep(2)

            self.set_status("Update installed. Rebooting…")
            subprocess.run("sudo reboot", shell=True)

        except Exception as e:
            self.set_status(f"Install failed: {e}")

    # ---------------- Helpers ----------------
    def download(self, url, dest):
        headers = {}
        if TOKEN:
            headers["Authorization"] = f"Bearer {TOKEN}"

        with requests.get(url, headers=headers, stream=True) as r:
            r.raise_for_status()
            with open(dest, "wb") as f:
                for chunk in r.iter_content(8192):
                    f.write(chunk)

    def copy_overwrite(self, src, dst):
        for item in os.listdir(src):
            s = os.path.join(src, item)
            d = os.path.join(dst, item)
            if os.path.isdir(s):
                shutil.rmtree(d, ignore_errors=True)
                shutil.copytree(s, d)
            else:
                shutil.copy2(s, d)

    def run_post_install(self):
        commands = [
            "sudo bash /home/pi/Desktop/fixpermissions.sh",
            "[ -f /home/pi/VNC.done ] || (sudo dpkg -i /home/pi/Desktop/VNC-Server-7.13.1-Linux-ARM.deb && touch /home/pi/VNC.done)",
            "[ -f /home/pi/ttf.done ] || (sudo apt-get update && sudo apt install libsdl2-ttf-dev -y && touch /home/pi/ttf.done)",
            "sudo chown -R pi:pi /home/pi/Desktop"
        ]

        for cmd in commands:
            self.set_status(f"Running: {cmd}")
            subprocess.run(cmd, shell=True, check=True)

    def set_status(self, msg):
        GLib.idle_add(self.status.set_text, msg)


# ---------------- RUN ----------------
if __name__ == "__main__":
    win = UpdaterGUI()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
