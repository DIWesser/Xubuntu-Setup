#!/bin/bash

# Check if run as root
    if [ "$UID" -ne "0" ] ; then # Actual check
        echo "This script must be run as root. (Use sudo.)"
        exit 1
    fi

# Install Franz
# Create and enter working folder to contain mess
mkdir franz-install-files
cd franz-install-files

wget --output-document=franz.tgz https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz # Download Franz application bundle
mkdir /opt/franz # Create installation location
tar -xf franz.tgz -C /opt/franz # Extract Franz bundle to installation location
wget --output-document=franz-icon.png "https://cdn-images-1.medium.com/max/360/1*v86tTomtFZIdqzMNpvwIZw.png" 

# Download icon
cp franz-icon.png /opt/franz/ # Move icon to install location

### Create *.desktop file (Allows app launchers etc to detect Franz)
touch /usr/share/applications/franz.desktop
echo "[Desktop Entry]" >> /usr/share/applications/franz.desktop
echo "Name=Franz" >> /usr/share/applications/franz.desktop
echo "Comment=" >> /usr/share/applications/franz.desktop
echo "Exec=/opt/franz/Franz" >> /usr/share/applications/franz.desktop
echo "Icon=/opt/franz/franz-icon.png" >> /usr/share/applications/franz.desktop
echo "Terminal=false" >> /usr/share/applications/franz.desktop
echo "Type=Application" >> /usr/share/applications/franz.desktop
echo "Categories=Messaging,Internet" >> /usr/share/applications/franz.desktop

### Clean up
cd ..
rm -rf franz-install-files
