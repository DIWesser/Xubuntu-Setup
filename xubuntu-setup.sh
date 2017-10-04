#!/bin/bash

#Check if run as root
    if [ $UID -ne 0 ] ; then
        echo "This script must be run as root. (Use sudo.)"
        exit 1
    fi

#########################################################################
# Prep
#########################################################################

# Send stray files to Desktop
cd Desktop

# Update everything before we begin
apt update
apt upgrade

#########################################################################
# System Settings
#########################################################################

# Change timezone to UTC
timedatectl set-timezone Etc/UTC

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

## Install Chrome
    sudo apt install libxss1 libappindicator1 libindicator7 # Install Dependencies (Already included in 16.04)
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb # Download Chrome
    dpkg -i google-chrome*.deb && apt-get install -f # Unpack Chrome and Install
    rm google-chrome-stable_current_amd64.deb # Remove .deb file

## Install Franz
    ###Create and enter working folder to contain mess
    mkdir franz-install-files
    cd franz-install-files

    wget --output-document=franz.tgz https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz # Download Franz application bundle
    mkdir /opt/franz # Create installation location
    tar -xf franz.tgz -C /opt/franz # Extract Franz bundle to installation location
    wget --output-document=franz-icon.png "https://cdn-images-1.medium.com/max/360/1*v86tTomtFZIdqzMNpvwIZw.png" # Download icon
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

# Install surge.sh
    npm install --global surge

#########################################################################
# Printer Setup
#########################################################################

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

# Have git cach cridentials in RAM for an hour
git config --global credential.helper "cache --timeout=3600"

#########################################################################
# Print user action notes
#########################################################################

# !!! Get this working !!!
# echo "foo" >> 'Post Install Todo.md'

echo "- [ ] Switch Window Manager theme to Numix" >> 'Post Install Todo.md'
echo "- [ ] switch compositor to compton" >> 'Post Install Todo.md'
echo "- [ ] Change LightDM settings" >> 'Post Install Todo.md'
echo "- [ ] [Scroll a background window without shifting focus on it](https://wiki.archlinux.org/index.php/xfce#Scroll_a_background_window_without_shifting_focus_on_it)" >> 'Post Install Todo.md'
echo "- [ ] Install Dropbox" >> 'Post Install Todo.md'
echo "      - [ ] [Fix Dropbox](https://askubuntu.com/questions/732816/xubuntu-dropbox-icon-fail)" >> 'Post Install Todo.md'
echo "- [ ] Record your encryption passphrase" >> 'Post Install Todo.md'
echo "- [ ] Look over the Arch Wiki page on XFCE if you have time to play with theming" >> 'Post Install Todo.md'
echo "- [ ] Install [AESCrypt](https://www.aescrypt.com/download/)" >> 'Post Install Todo.md'
echo "- [ ] Install [jGRASP](http://spider.eng.auburn.edu/user-cgi/grasp/grasp.pl?;dl=download_jgrasp.html)" >> 'Post Install Todo.md'
echo "- [ ] Walnut street printer set up based on [this Ubuntu forums thread](https://ubuntuforums.org/showthread.php?t=2350001)." >> 'Post Install Todo.md'

#########################################################################
# Finishing Touches
#########################################################################

# Remove unneeded dependencies
apt autoclean
apt autoremove

reboot # And now we turn it off and on again.
