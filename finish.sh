sudo wget https://github.com/druble81/cybershield/archive/refs/tags/current.zip
sudo unzip -o  current.zip -d /tmp/
sudo cp -a /tmp/cybershield-current/. /home/pi/Desktop
sudo chmod +x /home/pi/Desktop/fixpermissions.sh
sudo bash /home/pi/Desktop/fixpermissions.sh
sudo rm current.zip

sudo dpkg -i /home/pi/Desktop/wiringpi-latest.deb

# Install Matchbox virtual keyboard
echo "Installing Matchbox virtual keyboard..."
sudo apt update
sudo apt install -y matchbox-keyboard

# Create the toggle-keyboard.sh script
echo "Creating /usr/bin/toggle-keyboard.sh..."
sudo bash -c 'cat > /usr/bin/toggle-keyboard.sh' <<EOF
#!/bin/bash
PID="\$(pidof matchbox-keyboard)"
if [ "\$PID" != "" ]; then
    kill \$PID
else
    matchbox-keyboard &
fi
EOF

# Make the script executable
echo "Making /usr/bin/toggle-keyboard.sh executable..."
sudo chmod +x /usr/bin/toggle-keyboard.sh

# Create the desktop entry for toggle keyboard
echo "Creating /usr/share/raspi-ui-overrides/applications/toggle-keyboard.desktop..."
sudo mkdir -p /usr/share/raspi-ui-overrides/applications
sudo bash -c 'cat > /usr/share/raspi-ui-overrides/applications/toggle-keyboard.desktop' <<EOF
[Desktop Entry]
Name=Toggle Virtual Keyboard
Comment=Toggle Virtual Keyboard
Exec=/usr/bin/toggle-keyboard.sh
Type=Application
Icon=matchbox-keyboard.png
Categories=Panel;Utility;MB
X-MB-INPUT-MECHANISIM=True
EOF

# Backup and modify the panel configuration
echo "Modifying panel configuration..."
cp /etc/xdg/lxpanel/LXDE-pi/panels/panel /home/pi/.config/lxpanel/LXDE-pi/panels/panel
echo -e "\nPlugin {\n        type=launchbar\n        Config {\n                Button {\n                        id=toggle-keyboard.desktop\n                }\n        }\n}" >> /home/pi/.config/lxpanel/LXDE-pi/panels/panel

# Set up custom keyboard layout
echo "Setting up custom keyboard layout..."
mkdir -p /home/pi/.matchbox
sudo cp /usr/share/matchbox-keyboard/keyboard-lq1.xml /home/pi/.matchbox/keyboard.xml
sudo chown pi:pi /home/pi/.matchbox/keyboard.xml

#!/bin/bash

# Create the required directories
echo "Creating directories..."
mkdir -p ~/.config/lxsession/LXDE-pi

# Insert the specified lines into the autostart file
AUTOSTART_FILE=~/.config/lxsession/LXDE-pi/autostart

echo "Writing to $AUTOSTART_FILE..."
cat <<EOF > $AUTOSTART_FILE
@lxpanel --profile LXDE-pi
@pacmanfm --desktop --profile LXDE-pi
@sudo systemctl disable triggerhappy
@sudo systemctl stop triggerhappy
@lxterminal -e /home/pi/Desktop/I3/interface3
EOF

echo "Setup complete. Please reboot to apply changes."
