#!/bin/bash

# This is my post-install script for any fedora distro.
# Not sure why you'd use it, but here you go

# Set hostname
read -p "Enter hostname: " hostname
if [ $hostname ]
then
    sudo echo "$hostname" > /etc/hostname
else
    hostname="discworld"
    sudo echo "$hostname" > /etc/hostname
fi
echo "Hostname set to $hostname"

# Speed up dnf a touch
lines=('fastestmirror=true' 'defaultyes=true' 'max_parallel_downloads=10')
dnfconf="/etc/dnf/dnf.conf"
for line in "${lines[@]}"; do
	echo $line >> $dnfconf 
done
echo "'Fixed' dnf ;)"

# Upgrade system
echo "Upgrading system..."
sudo dnf upgrade

# Install my 'out of the box' progams
echo "Installing out of the box apps..."
sudo dnf install git neovim ranger zsh neofetch rofi vlc gh

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
