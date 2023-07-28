# debian-config
Personal debian config

Basic steps:

1) d-i install of Debian Bookworm KDE (EFI, ext4 /boot, encrypted XFS /root, GRUB2)
2) Switch to Debian Sid; add Siduction and Testing repos; set /etc/apt/preferences
3) Manual install of packages (including Siduction packages)
4) Manual purge of packages (including broken Debian Sid kernels)
5) Manual install of additional software (Zerotier, Mainline, timeshift-autosnap-apt)
6) Flatpak installs
