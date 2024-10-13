#!/bin/bash
set -e
#######################################################
# Author    : Ahmet Önder Moğol
# Description: This script adjusts MAKEFLAGS in /etc/makepkg.conf
#              based on the number of CPU cores
#######################################################

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then 
    log_message "Error: This script must be run as root"
    exit 1
fi

# Get the number of CPU cores
cpu_cores=$(grep -c ^processor /proc/cpuinfo)
log_message "Detected $cpu_cores CPU cores"

# Modify MAKEFLAGS in /etc/makepkg.conf
if sudo sed -i 's/^#MAKEFLAGS="-j2"/MAKEFLAGS="-j$(('"$cpu_cores"' + 1))"/' /etc/makepkg.conf; then
    log_message "Successfully updated MAKEFLAGS in /etc/makepkg.conf"
else
    log_message "Error: Failed to update MAKEFLAGS in /etc/makepkg.conf"
    exit 1
fi

# Verify the change
if grep MAKEFLAGS /etc/makepkg.conf | grep -q "j$((cpu_cores + 1))"; then
    log_message "Verification successful: MAKEFLAGS correctly set to -j$((cpu_cores + 1))"
else
    log_message "Error: MAKEFLAGS not set correctly in /etc/makepkg.conf"
    exit 1
fi

log_message "Script completed successfully"