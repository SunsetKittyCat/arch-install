# Add Users To Groups
for GROUP in $(cat '/usr/sbin/setup/groups'); do
    for HOME_USER in $(ls /home); do
        echo -e "Add User $HOME_USER To $GROUP Group"
        usermod -a -G $GROUP $HOME_USER
    done
done

# Recursively Execute All Install Scripts In A Directory
execute_scripts() {
    # Get Scripts
    SCRIPTS=$(find -H $1 -maxdepth 1 -type f ! -name 'setup.sh')
    
    # Execute Scripts For Every User
    for HOME_USER in $(ls /home); do
        echo -e "User Setup For $HOME_USER"
        for SCRIPT in $SCRIPTS; do
            doas -u $HOME_USER /bin/bash $SCRIPT
        done
    done
    
    # Recursively Execute All Install Scripts In The last Directory
    LAST=$1/last
    if [[ -d $LAST ]]; then
        execute_scripts $LAST
    fi
}

# Configure User Settings
execute_scripts '/usr/sbin/setup/user/setup/install'