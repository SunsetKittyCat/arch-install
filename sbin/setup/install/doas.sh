# Install doas For A Lightweight sudo Alternative
pacman --noconfirm --needed -S opendoas

# Smooth Transition From Sudo To Doas For Programs That Rely On sudo
ln -s $(which doas) /usr/bin/sudo

# Permit root User To Use doas Without Password Auth
# Permit Users In wheel Group To Use doas With Password Auth
echo -e 'permit nopass :root\npermit persist :wheel' > /etc/doas.conf

# Protect /etc/doas.conf
chown -c root:root /etc/doas.conf
chmod -c 0400 /etc/doas.conf