# Get CPU Vendor
CPU_VENDOR=$(lscpu | grep "Vendor")

# Install intel-ucode If CPU Vendor Is Intel
if [[ "${CPU_VENDOR,,}" =~ "intel" ]]; then
    pacman --noconfirm --needed -S intel-ucode
    # Install amd-ucode If CPU Vendor Is AMD
    elif [[ "${CPU_VENDOR,,}" =~ "amd" ]]; then
    pacman --noconfirm --needed -S amd-ucode
fi