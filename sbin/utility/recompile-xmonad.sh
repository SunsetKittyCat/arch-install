# Regenerate Package Database Cache
ghc-pkg recache

# Recompile Xmonad For Every User
for USER_HOME in $(/usr/bin/ls /home); do
    /usr/bin/doas -u $USER_HOME /usr/bin/xmonad --recompile
done