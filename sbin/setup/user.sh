# Prompt For User Creation
while read -p 'New User (Leave Empty To End User Creation): ' NEW_USER_NAME; do
    # Leave User Creation If New User Username Field Is Left Blank
    if [[ "$NEW_USER_NAME" == "" ]]; then
        break
    fi
    
    # Prompt For Whether Or Not New User Should Be Added To The wheel User Group
    read -p 'Add User $NEW_USER_NAME To Wheel Group (N/yes): ' WHEEL_GROUP
    if [[ "$WHEEL_GROUP" == "yes" ]]; then
        useradd -m -G wheel $NEW_USER_NAME
    else
        useradd -m $NEW_USER_NAME
    fi
    
    # Prompt For New User Password
    passwd $NEW_USER_NAME
done