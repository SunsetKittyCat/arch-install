# Let User Select Timezone
timezone=$(tzselect)
if [ -z "${timezone}" ]; then
    timezone=GMT+0
fi

# Set User-Selected Timezone
ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime

# Sync System Clock
hwclock --systohc