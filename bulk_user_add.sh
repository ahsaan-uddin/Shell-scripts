#!/bin/bash

# Define the group to which users will be added
GROUP="students"
# Define the default password for all users (change this to your preferred default password)
DEFAULT_PASSWORD="password123"

# Check if the user_list.txt file exists
if [ ! -f "user_list.txt" ]; then
    echo "user_list.txt file not found!"
    exit 1
fi

# Read the usernames from the file and create users
while IFS= read -r username; do
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
    else
        # Create the user with the specified group and home directory
        useradd -m -G "$GROUP" "$username"
        
        # Set the default password for the user
        echo "$username:$DEFAULT_PASSWORD" | chpasswd
        
        # Force the user to change the password on first login
        passwd --expire "$username"
        
        echo "User $username created and added to group $GROUP."
    fi
done < "user_list.txt"

echo "Bulk user creation completed."
