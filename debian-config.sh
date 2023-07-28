#! /bin/sh

# This is probably not a little dangerous and extremely janky.
# USE THIS AT YOUR OWN RISK

# Check if this script is running as root

if ! [ $(id -u) = 0 ]; then
   echo "I am not root!"
   exit 1
fi

echo "Running as root."

# Edit /etc/apt/sources.list and /etc/apt/preferences
# Switch to Debian Sid; add Debian Testing repo
# Update preferences to prefer Sid

echo "Modifying repositories and APT preferences..."

rm /etc/apt/sources.list
cat << EOF >> /etc/apt/sources.list
# Debian Sid
deb http://deb.debian.org/debian/ unstable main non-free-firmware non-free contrib
deb-src http://deb.debian.org/debian/ unstable main non-free-firmware non-free contrib

# Siduction
deb     https://mirror.math.princeton.edu/pub/siduction/extra unstable main
deb-src https://mirror.math.princeton.edu/pub/siduction/extra unstable main
deb     https://mirror.math.princeton.edu/pub/siduction/fixes unstable main contrib non-free 
deb-src https://mirror.math.princeton.edu/pub/siduction/fixes unstable main contrib non-free

# Debian Testing
#deb http://deb.debian.org/debian/ testing main non-free-firmware non-free contrib
#deb-src http://deb.debian.org/debian/ testing main non-free-firmware non-free contrib
EOF

cat << EOF >> /etc/apt/preferences
Package: *
Pin: release a=siduction
Pin-Priority: 1000

Package: *
Pin: release a=unstable
Pin-Priority: 990

Package: *
Pin: release a=testing
Pin-Priority: 100
EOF

apt-get update
apt-get upgrade

# Manual install of packages from Debian repos

echo "Installing packages from Debian repositories..."

apt-get --yes --force-yes install \
   apt-listbugs \
   aria2 \
   clamav-daemon \
   clamav-freshclam \
   clamtk \
   command-not-found \
   curl \
   dpkg-dev \
   fcitx5 \
   fcitx5-chinese-addons \
   fcitx5-jyutping \
   ffmpeg \
   filelight \
   firefox \
   firmware-amd-graphics \
   firmware-iwlwifi \
   firmware-linux \
   firmware-linux-free \
   firmware-linux-nonfree \
   firmware-misc-nonfree \
   firmware-sof-signed \
   flatpak \
   gettext \
   hunspell-en-gb \
   hunspell-en-us \
   hyphen-en-gb \
   hyphen-en-us \
   intel-microcode \
   kde-config-flatpak \
   kde-config-plymouth \
   libavcodec-extra \
   libgee-0.8-dev \
   libjson-glib-dev \
   libvte-2.91-dev \
   libreoffice-help-en-gb \
   libreoffice-help-en-us \
   libreoffice-java-common \
   libreoffice-kf5 \
   libreoffice-l10n-en-gb \
   libreoffice-plasma \
   libreoffice-qt5 \
   linux-cpupower \
   linux-headers-siduction-amd64 \
   linux-image-siduction-amd64 \
   linux-kbuild-6.3 \
   locales \
   lsb-release \
   make \
   nano \
   neofetch \
   network-manager-fortisslvpn \
   network-manager-openconnect \
   network-manager-openvpn \
   pipewire \
   pipewire-alsa \
   pipewire-audio \
   pipewire-bin \
   pipewire-pulse \
   plasma-desktop \
   plasma-thunderbolt \
   plasma-workspace-wayland \
   plymouth \
   plymouth-label \
   plymouth-themes \
   printer-driver-brlaser \
   printer-driver-cups-pdf \
   skanpage \
   steam-devices \
   synaptic \
   syncthing \
   syncthingtray \
   syncthingtray-kde-plasma \
   timeshift \
   tlp \
   tlp-rdw \
   upower \
   valac \
   wireguard \
   wireplumber \
   xdg-desktop-portal \
   xdg-desktop-portal-gtk \
   xdg-desktop-portal-kde \


# Manual purge of packages

echo "Removing packages..."

apt-get --yes --force-yes purge \
   akregator \
   dragonplayer \
   firefox-esr \
   juk \
   kaddressbook \
   kdepim \
   kmail \
   knotes \
   konq-plugins \
   konqueror \
   korganizer \
   kwrite \
   linux-headers-amd64 \
   linux-image-amd64 \
   pim-data-exporter \
   pim-sieve-editor \
   pulseaudio \
   pulseaudio-module-gsettings \
   pulseaudio-module-bluetooth

# Manual install of additional software

echo "Installing additional software..."

echo "Installing Zerotier..."
curl -s https://install.zerotier.com | bash

echo "Installing timeshift-autosnap-apt..."
git clone https://github.com/wmutschl/timeshift-autosnap-apt.git
cd ./timeshift-autosnap-apt
make install
cd ..

echo "Installing Mainline..."
git clone https://github.com/bkw777/mainline.git
cd ./mainline
make
make install
cd ..
