# Install networkmanager For A Network Manager With A CLI Interface
pacman --noconfirm --needed -S networkmanager

# Enable networkmanager Service
systemctl enable NetworkManager.service