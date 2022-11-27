# Install grub For A Bootloader With A Lot Of Feature Support
pacman --noconfirm --needed -S grub

# If The System Is Booted In UEFI, Install GRUB On The EFI Partition
if [[ -d /sys/firmware/efi/ ]]; then
    pacman --noconfirm --needed -S efibootmgr
    
    mkdir -p /boot/efi
    mount $(df / | grep / | awk '{print $1}' | head -c -2)1 /boot/efi
    
    grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
    
    # If The System Is Not Booted In UEFI, Install GRUB On The Current Drive
else
    grub-install --target=i386-pc $(df / | grep / | awk '{print $1}')
fi

# Hide The GRUB Menu On Boot
sed -i "s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0\nGRUB_TIMEOUT_STYLE=hidden/" /etc/default/grub

# Generate grub.cfg
grub-mkconfig -o /boot/grub/grub.cfg