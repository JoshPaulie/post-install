#!/bin/bash

# This is my post-install script for any fedora distro.
# Not sure why you'd use it, but here you go

# Set hostname
defaultHostname="discworld"
read -p "Enter hostname (default is $defaultHostname): " hostname
if ! [ $hostname ]; then
    hostname=$defaultHostname
fi
sudo echo "$hostname" > /etc/hostname
echo "Hostname set to $hostname"

# DNF changes
echo "Fixing dnf..."
# Speed up changes
lines=('fastestmirror=true' 'defaultyes=true' 'max_parallel_downloads=10')
dnfconf="/etc/dnf/dnf.conf"
for line in "${lines[@]}"; do
	echo $line >> $dnfconf 
done

# Upgrade system
echo "Upgrading system..."
sudo dnf upgrade

# Enable RPM Fusion
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install my 'out of the box' progams
echo "Installing out of the box apps..."
sudo dnf install neovim ranger zsh neofetch rofi gh discord

# Install starship
echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh

# Change shell to zsh
# Requires relog to take effect, handled by restart at the end
echo "Changing shell to zsh..."
chsh -s $(which zsh)

# Restart system (Best practice after first install)
echo "Restarting system..."
sleep 5
restart
