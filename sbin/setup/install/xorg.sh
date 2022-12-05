# Install xorg xf86-video-vesa xf86-video-fbdev xorg-xinit For xorg Capabilities Along With Basic Drivers And The Capability To Start Xorg With A Display Manager
pacman --noconfirm --needed -S xorg xf86-video-vesa xf86-video-fbdev xorg-xinit

# Get Graphics Cards
GPU_VENDORS=$(tr '[:upper:]' '[:lower:]' <<< $(lspci -v | grep -A1 -e VGA -e 3D))

# If AMD GPU Is Present, Install xf86-video-amdgpu mesa vulkan-radeon libva-mesa-driver mesa-vdpau For AMD GPU Acceleration And Vulkan Support
if [[ $GPU_VENDORS =~ "amd" ]]; then
    pacman --noconfirm --needed -S xf86-video-amdgpu mesa vulkan-radeon libva-mesa-driver mesa-vdpau
    echo -e 'Section "Device"\n     Identifier "AMD"\n     Driver "amdgpu"\n     Option "TearFree" "true"\n     Option "DRI" "3"\n     Option "VariableRefresh" "true"\nEndSection' > /etc/X11/xorg.conf.d/20-amdgpu.conf
fi
# If Intel GPU Is Present, Install xf86-video-intel mesa vulkan-intel intel-media-driver For Intel GPU Acceleration And Vulkan Support
if [[ $GPU_VENDORS =~ "intel" ]]; then
    pacman --noconfirm --needed -S xf86-video-intel mesa vulkan-intel intel-media-driver
    echo -e 'Section "Device"\n     Identifier "Intel Graphics"\n     Driver "intel"\n	 Option "AccelMethod" "sna"\n	 Option "TearFree" "true"\nEndSection' > /etc/X11/xorg.conf.d/20-intel.conf
fi
# If NVidia GPU Is Present, Install nvidia nvidia-utils For NVidia GPU Acceleration And Vulkan Support
if [[ $GPU_VENDORS =~ "nvidia" ]]; then
    pacman --noconfirm --needed -S nvidia nvidia-utils
    nvidia-xconfig
fi