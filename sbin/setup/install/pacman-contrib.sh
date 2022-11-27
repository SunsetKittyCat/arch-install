# Install pacman-contrib For An Automatic Old pacman Package Version Deletion Utility
pacman --noconfirm --needed -S pacman-contrib

# Delete All Chached Versions Of Packages Except For The Most Recent Three
paccache -r

# Discard Unused Packages Weekly
systemctl enable paccache.timer