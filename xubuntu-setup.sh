#!/bin/bash

#Check if run as root
    if [ "$UID" -ne "0" ] ; then # Actual check
        echo "This script must be run as root. (Use sudo.)"
        exit 1
    fi

#########################################################################
# Prep
#########################################################################

cd Desktop # Send stray files to Desktop

# Update everything before we begin
apt update
apt upgrade

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
       apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE # Typora repo signing keys
       add-apt-repository -y 'deb https://typora.io ./linux/' # Typora repo
    #add-apt-repository -y ppa:elementary-os/stable # Geary and/or Pantheon Files
    #add-apt-repository -y ppa:elementary-os/daily # Pantheon Files Dropbox plugin
    add-apt-repository -y ppa:flexiondotorg/albert # Albert launcher
    add-apt-repository -y ppa:snwh/pulp # Paper GTK and icon themes
    add-apt-repository -y ppa:neovim-ppa/stable # Neovim
    #add-apt-repository ppa:jeffreyratcliffe/ppa # More up to date version of gscan2pdf (It's Grumpy though.)
    add-apt-repository ppa:webupd8team/java # Java 8 JDK installer

apt update # Update repository and app lists

## Remove unneeded apps
    apt remove gnome-mines
    apt remove gnome-sudoku
    apt remove libreoffice-math
    apt remove orage
    apt remove pidgin
    apt remove xfce4-notes

## Install apps
    apt install -y abcde # CLI CD ripper
    apt install -y albert # Launcher simular to macOS Spotlight
    apt install -y calibre
    apt install -y compton # Display compositor. Helps deal with screen tearing problems.
    apt install -y eclipse # IDE (Java, etc)
    apt install -y git # If you don't know what this is, don't install it.
    apt install -y gnome-disk-utility
    apt install -y gscan2pdf # Scanning program with OCR. It's a bit grumpy.
    apt install -y htop # CLI activity monitoring.
    apt install -y inkscape # Vector graphics editor
    apt install -y libdvd-pkg
    apt install -y libreoffice-impress
    apt install -y lsb-core # Needed for jGRASP
    apt install -y nautilus # File manager that plays better with Dropbox.
                            # However, Thunar and Dropbox have been getting along lately.
    apt install -y neovim
    apt install -y nmap
    #apt install -y npm
    apt install -y ntp
    apt install -y oracle-java8-installer # Java 8 runtime and JDK
    apt install -y oracle-java8-set-default
    apt install -y pandoc
    apt install -y paper-gtk-theme
    apt install -y paper-icon-theme
    apt install -y ranger # Command line file manager with Vim bindings
    apt install -y redshift # 
    apt install -y screenfetch
    apt install -y testdisk
    apt install -y tmux
    apt install -y tree
    apt install -y typora # Markdown editor
    apt install -y ubuntu-restricted-extras
    apt install -y vim
    apt install -y vlc

snap install keepassxc

## Remove things that may have been added that you don't want
apt remove libreoffice-draw

# Non-repo programs
    # Chrome
        chmod +x resources/install-chrome.sh
        ./resources/install-chrome.sh
    # Franz
        chmod +x resources.install-franz.sh
        ./resources.install-franz.sh
    # Extra Typora Themes
        chmod +x resources/install-typora-themes.sh
        ./resources/install-typora-themes.sh
    # surge.sh
        npm install --global surge

# Printer Drivers
    # Canon MX470
        chmod +x resources/canon-mx470-setup.sh
        ./resources/canon-mx470-setup.sh

#########################################################################
# Styling
#########################################################################

# !!! Importing dotfiles would render most of this moot. !!!

# Set theme
    xfconf-query -c xsettings -p /Net/ThemeName -s "Numix"
    xfconf-query -c xsettings -p /Net/IconThemeName -s "Paper"

# XCFE4 Panel Settings
## Set Panel Autohide Time
    echo "style "xfce-panel-window-style"" >> "~/.gtkrc-2.0"
    echo "{" >> "~/.gtkrc-2.0"
    echo "  # Time in miliseconds before the panel will unhide on an enter event" >> "~/.gtkrc-2.0"
    echo "  XfcePanelWindow::popup-delay = 1" >> "~/.gtkrc-2.0"
    echo " " >> "~/.gtkrc-2.0"
    echo "  # Time in miliseconds before the panel will hide on a leave event" >> "~/.gtkrc-2.0"
    echo "  XfcePanelWindow::popdown-delay = 1" >> "~/.gtkrc-2.0"
    echo "}" >> "~/.gtkrc-2.0"
    echo "class "XfcePanelWindow" style "xfce-panel-window-style"" >> "~/.gtkrc-2.0"

#########################################################################
# UI Settings
#########################################################################

# Enable two finger horozontal scrolling with trackpad
# !!! Doesn't persist accross reboots !!!
    #synclient HorizTwoFingerScroll=1
    #synclient HorizScrollDelta=101

# Require username to be entered at login
    touch /etc/lightdm/lightdm.conf
    echo '[SeatDefaults]' >> /etc/lightdm/lightdm.conf
    #echo 'greeter-show-manual-login=true' >> /etc/lightdm/lightdm.conf
    echo 'greeter-hide-users=true' >> /etc/lightdm/lightdm.conf

# Change default view in Nautilus file manager to "List View"
    gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'

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
