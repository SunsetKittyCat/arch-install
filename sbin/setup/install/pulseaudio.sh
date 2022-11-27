# Install pulseaudio pulsemixer For pulseaudio Capabilities And A CLI Sound Mixer
pacman --noconfirm --needed -S pulseaudio pulsemixer

# Disable Suspending Modules On Idle So That Modules Do Not Randomly Disappear
sed -i 's/load-module module-suspend-on-idle/#&/' /etc/pulse/default.pa