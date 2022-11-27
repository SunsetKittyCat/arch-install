# Recursively Execute All Install Scripts In A Directory
execute_scripts() {
    # Execute Scripts
    for SCRIPT in $(find -H $1 -maxdepth 1 -type f ! -name "setup.sh" ! -name "user.sh"); do
        /bin/bash $SCRIPT
    done
    
    # Recursively Execute All Install Scripts In The last Directory
    LAST=$1/last
    if [[ -d $LAST ]]; then
        execute_scripts $LAST
    fi
}

# Run General Setup Scripts
execute_scripts "/usr/sbin/setup"
# Install Packages
execute_scripts "/usr/sbin/setup/install"