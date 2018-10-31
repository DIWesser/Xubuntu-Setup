#!/bin/bash
#
# Todo:
# - Make more generic
# - Add ability to detect what distro and DE this is being run

#Check if run as root
if [ "$UID" -ne "0" ] ; then # Actual check
    echo "This script must be run as root. (Use sudo.)"
    exit 1
fi

#########################################################################
# Prep
#########################################################################

cd Desktop # Send stray files to Desktop

# Detect desktop environment
de=gnome

# Update everything before we begin
apt update
apt upgrade -y

#########################################################################
# System Settings
#########################################################################

timedatectl set-timezone Etc/UTC # Change timezone to UTC

#########################################################################
# Installing Things
#########################################################################

# Repo Apps

## Add Repositories
   # Typora
       # Signing keys
       apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
       # Repository
       add-apt-repository -y 'deb https://typora.io ./linux/'
    #add-apt-repository -y ppa:elementary-os/stable  # Geary and Pantheon Files
    #add-apt-repository -y ppa:elementary-os/daily   # Pantheon Files Dropbox plugin
#    add-apt-repository -y ppa:flexiondotorg/albert   # Albert launcher
#    add-apt-repository -y ppa:snwh/pulp              # Paper GTK and icon themes
#    add-apt-repository -y ppa:neovim-ppa/stable      # Neovim
    #add-apt-repository -y ppa:jeffreyratcliffe/ppa   # More up to date version of gscan2pdf (It's Grumpy though.)
#    add-apt-repository -y ppa:webupd8team/java       # Java 8 JDK installer
#    add-apt-repository -y ppa:phoerious/keepassxc    # KeePassXC
#    add-apt-repository -y ppa:smathot/cogscinl       # Zotero

apt update # Update repository and app lists

# Remove unneeded apps
apt remove gnome-mines
apt remove gnome-sudoku
apt remove libreoffice-math
apt remove orage
apt remove pidgin
apt remove xfce4-notes

# Install apps
apt install -y abcde        # CLI CD ripper
#apt install -y albert       # Launcher simular to macOS's Spotlight
apt install -y calibre      # Ebook manager (Repo version is outdated)
apt install -y chrome-gnome-shell # Gnome browser integration
#apt install -y compton      # Display compositor. Fixes Xubuntu screen tearing
#apt install -y eclipse      # IDE (Java, etc)
apt install -y evolution    # Needed to sign into Gnome Calendar
apt install -y festival     # Text to speach
apt install -y git          # If you don't know what this is, don't install it.
apt install -y gnome-calendar
apt install -y gnome-disk-utility
apt install -y gnome-dictionary
apt install -y gnome-shell-extensions # Makes Gnome work much better
apt install -y gnome-sushi  # Quick Look for Nautilus
#apt install -y gscan2pdf    # Scanning program with OCR. It's a bit grumpy.
apt install -y htop         # CLI activity monitoring.
#apt install -y inkscape     # Vector graphics editor
apt install -y keepassxc    # Password manager
#apt install -y krita        # Drawing app
apt install -y libdvd-pkg
apt install -y libcanaberra-gtk-module # Makes some unimportant console errors from Okular go away
apt install -y libreoffice-calc
apt install -y libreoffice-gtk # Neede for GTK theme integration
apt install -y libreoffice-impress
apt install -y libreoffice-style-breeze
apt install -y libreoffice-writer
#apt install -y lsb-core     # Needed for jGRASP
apt install -y mpv          # CLI media player
#apt install -y nautilus     # File manager that plays better with Dropbox.
#                            # However, Thunar and Dropbox have been working
#apt install -y neovim       # CLI text editor
apt install -y nmap
#apt install -y npm
apt install -y ntp          # Network Time Protocol
apt install -y okular       # PDF viewer/editor
#apt install -y oracle-java8-installer # Java 8 runtime and JDK
#apt install -y oracle-java8-set-default
apt install -y pandoc       # Document converter
#apt install -y paper-gtk-theme
#apt install -y paper-icon-theme
apt install -y pdfsandwich  # OCR PDFs
apt install -y ranger       # Command line file manager with Vim bindings
apt install -y redshift     # 
apt install -y rofi         # Application launcher
#apt install -y screenfetch  # System info
apt install -y testdisk
apt install -y tesseract-ocr     # OCR
apt install -y tesseract-ocr-all # Languages for Tesseract
apt install -y tmux         # Terminal multiplexer
apt install -y torbrowser-launcher # Essentially the TOR Browser
apt install -y transmission # Torrent client
apt install -y tree         # Prints file paths in tree format
apt install -y typora       # Markdown editor
apt install -y ubuntu-restricted-extras
apt install -y unoconv      # ODT, etc. support for gnome-sushi
#apt install -y vim
apt install -y vlc          # Media player
apt install -y xsel         # Handles selected text in my scripts
apt install -y zotero-standalone # Reference manager

# Non-repo programs

# youtube-dl
# Repo version is slow to update.
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o \
    /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

#    # Chrome
#        chmod +x resources/install-chrome.sh
#        ./resources/install-chrome.sh
#    # Franz
#        chmod +x resources.install-franz.sh
#        ./resources.install-franz.sh
#    # Extra Typora Themes
#        chmod +x resources/install-typora-themes.sh
#        ./resources/install-typora-themes.sh
#    # surge.sh
#        npm install --global surge

# Printer Drivers
    # Canon MX470
#        chmod +x resources/canon-mx470-setup.sh
#        ./resources/canon-mx470-setup.sh

#########################################################################
# Styling
#########################################################################

# !!! Importing dotfiles would render most of this moot. !!!

# Set theme
#    xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
#    xfconf-query -c xsettings -p /Net/IconThemeName -s "Paper"

# XCFE4 Panel Settings
## Set Panel Autohide Time
#    echo 'style "xfce-panel-window-style"'                     >> "~/.gtkrc-2.0"
#    echo "{"                                                   >> "~/.gtkrc-2.0"
#    echo "  # Time in miliseconds before the panel will unhide on an enter event" \
#                                                               >> "~/.gtkrc-2.0"
#    echo "  XfcePanelWindow::popup-delay = 1"                  >> "~/.gtkrc-2.0"
#    echo " "                                                   >> "~/.gtkrc-2.0"
#    echo "  # Time in miliseconds before the panel will hide on a leave event" \
#                                                               >> "~/.gtkrc-2.0"
#    echo "  XfcePanelWindow::popdown-delay = 1"                >> "~/.gtkrc-2.0"
#    echo "}"                                                   >> "~/.gtkrc-2.0"
#    echo 'class "XfcePanelWindow" style "xfce-panel-window-style"' \
#                                                               >> "~/.gtkrc-2.0"

#########################################################################
# UI Settings
#########################################################################

# Enable two finger horozontal scrolling with trackpad
# !!! Doesn't persist accross reboots !!!
    #synclient HorizTwoFingerScroll=1
    #synclient HorizScrollDelta=101

# Disable natural scrolling
if [[ de=gnome ]] ; then
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
else
    echo "Scroll direction cannot be changed in your desktop environment."
fi

# Require username to be entered at login
#    touch /etc/lightdm/lightdm.conf
#    echo '[SeatDefaults]' >> /etc/lightdm/lightdm.conf
    #echo 'greeter-show-manual-login=true' >> /etc/lightdm/lightdm.conf
#    echo 'greeter-hide-users=true' >> /etc/lightdm/lightdm.conf

# Change default view in Nautilus file manager to "List View"
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'

# Show battery percentage in Gnome menu bar
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Use GTK theme with Qt apps
apt install qt5-style-plugins
echo "" >> ~/.profile
echo "# Use GTK themes with Qt apps" >> ~/.profile
echo "export QT_QPA_PLATFORMTHEME=gtk2" >> ~/.profile

#########################################################################
# Misc. Settings
#########################################################################

# Have git cache credentials in RAM for an hour
git config --global credential.helper "cache --timeout=3600"

#########################################################################
# Finishing Touches
#########################################################################

# Print user action notes
cp resourses/post-install-todo.md ~/Desktop/Readme.md

# Remove unneeded dependencies
apt autoclean
apt autoremove

reboot # And now we turn it off and on again.
