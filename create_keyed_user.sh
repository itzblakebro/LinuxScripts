## Create a basic user and move the key files from root to that user
## Usage chmod +x create_keyed_user.sh ; sudo ./create_keyed_user username

#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# Check if a username is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

# Set the username from the argument
USERNAME=$1

# Create the user and add them to the sudo group
# useradd -m -G sudo "$USERNAME"

adduser "$USERNAME"
usermod -aG sudo "$USERNAME"

# # Create the .ssh folder in the user's home directory
mkdir -p "/home/$USERNAME/.ssh"

# Copy the authorized key file from the root user to the user's .ssh folder
cp ~/.ssh/authorized_keys "/home/$USERNAME/.ssh/"

# Set appropriate permissions and ownership
chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"
chmod 700 "/home/$USERNAME/.ssh"
chmod 600 "/home/$USERNAME/.ssh/authorized_keys"

echo "User $USERNAME has been created and configured."