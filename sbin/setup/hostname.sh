# Generate Random Hostname
echo "DESKTOP-$(tr -dc A-Z0-9 </dev/urandom | head -c 7)" > /etc/hostname