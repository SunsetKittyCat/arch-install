# Check Connection To Internet
if ! $(nc -zw1 archlinux.org 80); then
    echo "Not Connected To The Internet"
    exit 1
fi


# Update System Clock
timedatectl set-ntp true


# Check If An Element Exists In A String
contains_element() {
    for e in "${@:2}"; do [[ "$e" == "$1" ]] && break; done
}


# Get List Of Drives
DRIVE_LIST=($(lsblk -d | awk '{print "/dev/" $1}' | grep 'sd\|hd\|vd\|nvme\|mmcblk') 'Device Details')

# Set Prompt
PS3=$'\nSelect A Drive To Parition: '

# Prompt User For The Drive That Should Be Partitioned
# If Chosen By User, Display The Details Of Each Drive So That The User May More Easily Identify The Drive That They Want To Partition
select DRIVE in "${DRIVE_LIST[@]}"; do
    # Clear Previous Prompt Lines
    echo -en "\033[$((${#DRIVE_LIST[@]} + 2))F\033[J"
    
    # If Chosen, Display Drive Details
    if [[ "${DRIVE}" == "${DRIVE_LIST[-1]}" ]]; then
        echo -e "Drive Details\n\n$(lsblk -d | awk '{print "/dev/" $1 "\t" $4}' | grep 'sd\|hd\|vd\|nvme\|mmcblk')\n"
        
        # If Chosen, Select drive
        elif contains_element "${DRIVE}" "${DRIVE_LIST[@]}"; then
        break
    fi
    
    # Reset Reply
    REPLY=
done


# Get The Size Of The Drive In Bytes
DRIVE_SIZE=$(lsblk -b --output SIZE -n -d "$DRIVE")

# Check Adequate Drive Size
if [[ $DRIVE_SIZE -le 4294967296 ]]; then
    echo "Not Enough Space On Drive $DRIVE"
    exit 2
fi


# Create GPT Partition Scheme
# ESP 300 MiB, Swap 2GB
if [[ -d /sys/firmware/efi/ ]]; then
    parted -s -a optimal "$DRIVE" \
    mklabel gpt \
    mkpart fat32 1MiB 301MiB \
    set 1 esp on \
    mkpart linux-swap 301MiB 2349MiB \
    mkpart ext4 2349MiB $(($DRIVE_SIZE - 17408))B \
    align-check optimal 1 \
    align-check optimal 2 \
    align-check optimal 3
    
    # Set Partition Variables
    PARTITIONS=$(fdisk -l $DRIVE | grep '^/dev' | cut -d' ' -f1)
    ESP_PARTITION=$(echo "$PARTITIONS" | sed -n 1p)
    SWAP_PARTITION=$(echo "$PARTITIONS" | sed -n 2p)
    ROOT_PARTITION=$(echo "$PARTITIONS" | sed -n 3p)
    
    # Format Partiions
    mkfs.fat -F 32 $ESP_PARTITION
    mkswap $SWAP_PARTITION
    mkfs.ext4 $ROOT_PARTITION
    
    # Mount Partitions
    mount $ROOT_PARTITION /mnt
    mount --mkdir $ESP_PARTITION /mnt/boot
    swapon $SWAP_PARTITION
    
    # Create MSDOS Partition Scheme
    # Swap 2GB
else
    parted -s -a optimal "$DRIVE" \
    mklabel msdos \
    mkpart primary linux-swap 1MiB 2049MiB \
    mkpart primary ext4 2049MiB $(($DRIVE_SIZE - 17408))B \
    set 2 boot on \
    align-check optimal 1 \
    align-check optimal 2
    
    # Set Partition Variables
    PARTITIONS=$(fdisk -l $DRIVE | grep '^/dev' | cut -d' ' -f1)
    SWAP_PARTITION=$(echo "$PARTITIONS" | sed -n 1p)
    ROOT_PARTITION=$(echo "$PARTITIONS" | sed -n 2p)
    
    # Format Partitions
    mkswap $SWAP_PARTITION
    mkfs.ext4 $ROOT_PARTITION
    
    # Mount Partitions
    mount $ROOT_PARTITION /mnt
    swapon $SWAP_PARTITION
fi


# Install Essential Packages
pacstrap /mnt base linux linux-firmware


# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab


# Copy Install Scripts To ext4 Partition
cp -r ./sbin/* /mnt/usr/sbin/
cp -r ./bin/* /mnt/usr/bin/


# Execute Package Installation And Configuration Scripts
arch-chroot /mnt /usr/bin/bash /usr/sbin/setup/setup.sh


# Create Users
arch-chroot /mnt /usr/bin/bash /usr/sbin/setup/user.sh


# Execute User Config Scripts
arch-chroot /mnt /usr/bin/bash /usr/sbin/setup/user/setup/setup.sh


# Create A New initramfs
arch-chroot /mnt /usr/bin/mkinitcpio -P


# Change Root Password
echo -e "Change Root Password"
arch-chroot /mnt /usr/bin/passwd


# Remove Setup Scripts
rm -r /mnt/usr/sbin/setup