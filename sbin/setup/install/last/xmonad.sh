# Install xmonad xmonad-contrib xsecurelock xss-lock playerctl usbguard stalonetray xmobar For An X Tiling Window Manager, Secure Session Locking Locking, Controlling Media Players, Getting The Camera Status And Allowing/Blocking The Camera, A Tasktray, And A Taskbar
pacman --noconfirm --needed -S xmonad xmonad-contrib xsecurelock xss-lock playerctl usbguard stalonetray xmobar

# Recompile Xmonad Every Time That It Is Updated
mkdir -p /etc/pacman.d/hooks
echo -e "[Trigger]\nOperation = Upgrade\nType = Package\nTarget = xmonad\n\n[Action]\nDescription = Recompiling xmonad...\nWhen = PostTransaction\nExec = /usr/sbin/utility/recompile-xmonad.sh" > /etc/pacman.d/hooks/xmonad.hook