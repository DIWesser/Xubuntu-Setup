#!/bin/bash

# Check if run as root
    if [ "$UID" -ne "0" ] ; then # Actual check
        echo "This script must be run as root. (Use sudo.)"
        exit 1
    fi

# Install Dependencies (Already included in 16.04)
apt install libxss1 libappindicator1 libindicator7 
# Download
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# Install
dpkg -i google-chrome*.deb && apt-get install -f
# Cleanup
rm google-chrome-stable_current_amd64.deb
