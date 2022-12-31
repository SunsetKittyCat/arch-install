# Install xmonad xmonad-contrib xsecurelock xss-lock playerctl usbguard stalonetray xmobar light For An X Tiling Window Manager, Secure Session Locking Locking, Controlling Media Players, Getting The Camera Status And Allowing/Blocking The Camera, A Tasktray, A Taskbar, And A Backlight Manager
pacman --noconfirm --needed -S xmonad xmonad-contrib xsecurelock xss-lock playerctl usbguard stalonetray xmobar light

# Recompile Xmonad Every Time That It Is Updated
mkdir -p /etc/pacman.d/hooks
echo -e '[Trigger]\nOperation = Upgrade\nType = Package\nTarget = xmonad\n\n[Action]\nDescription = Recompiling xmonad...\nWhen = PostTransaction\nExec = /usr/bin/bash -c '"'"'/usr/sbin/utility/recompile-xmonad.sh'"'" > /etc/pacman.d/hooks/xmonad.hook