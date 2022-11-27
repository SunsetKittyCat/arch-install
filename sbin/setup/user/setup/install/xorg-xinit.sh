cp /etc/X11/xinit/xinitrc ~/.xinitrc

# Remove Default xinitrc Behavior
sed -i "/twm/d" ~/.xinitrc
sed -i "/xclock/d" ~/.xinitrc
sed -i "/xterm/d" ~/.xinitrc

# Change Cursor To An Arrow-Shaped Cursor
echo -e "xsetroot -cursor_name left_ptr" >> ~/.xinitrc