#!/bin/bash

# Install Canon MX470 series Drivers
# The following script is based off of advice from a thread in the Linux Mint Forum (https://forums.linuxmint.com/viewtopic.php?t=165407)

## Canon MX470 Drivers
    wget --output-document=cnijfilter-mx470series-4.10-1-deb.tar.gz "http://pdisp01.c-wss.com/gdl/WWUFORedirectTarget.do?id=MDEwMDAwNTg2OTAx&amp;cmp=ACB&amp;lang=EN" # Download Installer Bundle
    tar -zxvf cnijfilter-mx470series-4.10-1-deb.tar.gz # Unzip Installer Bundle
    cd cnijfilter-mx470series-4.10-1-deb # Change working directory to installer folder
    ./install.sh # Run Installer
    cd .. # Back out of Installer Folder
    rm -rf cnijfilter-mx470series-4.10-1-deb # Remove Installer Folder and Bundle
    rm cnijfilter-mx470series-4.10-1-deb.tar.gz # Remove Installer Folder and Bundle

## Scanning
    wget --output-document=scangearmp-mx470series-2.30-1-deb.tar.gz "http://pdisp01.c-wss.com/gdl/WWUFORedirectTarget.do?id=MDEwMDAwNTg3MTAx&amp;cmp=ACB&amp;lang=EN" # Download Installer Bundle
    tar -zxvf scangearmp-mx470series-2.30-1-deb.tar.gz # Unzip Installer Bundle
    cd scangearmp-mx470series-2.30-1-deb # Change Working Directory to Installer Folder
    ./install.sh # Run Installer
    cd .. # Back Out of Installer Folder
    rm -rf scangearmp-mx470series-2.30-1-deb # Remove Installer folder
    rm scangearmp-mx470series-2.30-1-deb.tar.gz # Remove Installer Bundle
