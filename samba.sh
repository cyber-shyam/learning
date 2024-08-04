#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Please run with sudo." 
   exit 1
fi

# Variables
SAMBA_GROUP="sambashare"
CONFIG_FILE="/etc/samba/smb.conf"

# Function to install Samba if not already installed
install_samba() {
    if ! command -v smbd &> /dev/null; then
        echo "Samba is not installed. Installing now..."
        apt update
        apt install -y samba

        # Check if the installation was successful
        if [[ $? -ne 0 ]]; then
            echo "Samba installation failed. Exiting."
            exit 1
        fi

        echo "Samba installed successfully."
    else
        echo "Samba is already installed."
    fi
}

# Function to backup the Samba configuration if not already backed up
backup_config() {
    if [[ -f $CONFIG_FILE && ! -f "${CONFIG_FILE}.bak" ]]; then
        echo "Backing up the original Samba configuration file..."
        cp $CONFIG_FILE "${CONFIG_FILE}.bak"
    else
        echo "Samba configuration file already backed up or does not exist."
    fi
}

# Function to configure Samba if not already configured
configure_samba() {
    echo "Configuring Samba..."

    # Create a Samba group if it doesn't exist
    if ! getent group $SAMBA_GROUP >/dev/null; then
        groupadd $SAMBA_GROUP
    fi

    # Check if Samba is already configured for any user
    if grep -q "valid users" $CONFIG_FILE; then
        echo "Samba is already configured. Skipping configuration."
    else
        echo "Samba configuration completed."
    fi
}

# Function to restart Samba services
restart_samba_services() {
    echo "Restarting Samba services..."
    systemctl restart smbd nmbd

    # Enable Samba to start on boot
    echo "Enabling Samba to start on boot..."
    systemctl enable smbd nmbd

    echo "Samba services restarted and enabled on boot."
}

# Function to configure the firewall
configure_firewall() {
    echo "Configuring firewall..."

    # Allow Samba ports through UFW
    if command -v ufw >/dev/null; then
        ufw allow 137,138/udp
        ufw allow 139,445/tcp
        ufw reload
        echo "Firewall configured for Samba."
    else
        echo "UFW not found. Skipping firewall configuration."
    fi
}

# Function to create a Linux user and a Samba share for the user
create_user_and_share() {
    read -p "Enter the username: " username
    read -p "Enter the full name: " fullname
    read -s -p "Enter the password: " password
    echo

    # Create a new system user if it doesn't already exist
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping user creation."
    else
        useradd -m -c "$fullname" -s /bin/bash -G $SAMBA_GROUP "$username"
        echo "$username:$password" | chpasswd
        echo "User $username created successfully."
    fi

    local user_home_dir=$(eval echo "~$username")
    local share_dir="$user_home_dir/share"

    # Create a shared directory for the user
    mkdir -p "$share_dir"

    # Set permissions for the shared directory
    chown "$username":"$SAMBA_GROUP" "$share_dir"
    chmod 2770 "$share_dir"

    # Append user-specific configuration to the smb.conf file if not already present
    if ! grep -q "^\[$username\]" $CONFIG_FILE; then
        cat <<EOL >> $CONFIG_FILE

[$username]
   path = $share_dir
   browseable = yes
   read only = no
   valid users = $username
   create mask = 0660
   directory mask = 2770
EOL
        echo "Samba share for user $username created at $share_dir."
    else
        echo "Samba share for user $username already exists."
    fi

    # Set Samba password for the user
    echo -e "$password\n$password" | smbpasswd -a -s $username
    echo "Samba password set for user $username."
}

# Main script execution
install_samba
backup_config
configure_samba
restart_samba_services
configure_firewall

while true; do
    create_user_and_share
    read -p "Do you want to create another user? (y/n): " choice
    if [[ $choice != "y" && $choice != "Y" ]]; then
        break
    fi
done

echo "All tasks completed successfully."
