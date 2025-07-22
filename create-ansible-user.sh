#!/bin/bash

set -e

USERNAME="ansible"
GITHUB_USER="jackcoble"

# Check if user exists, create if not
if ! id "$USERNAME" &>/dev/null; then
    sudo useradd -m -s /bin/bash "$USERNAME"
    echo "User '$USERNAME' created."
fi

# Allow passwordless sudo
SUDOERS_FILE="/etc/sudoers.d/$USERNAME"
if [ ! -f "$SUDOERS_FILE" ]; then
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee "$SUDOERS_FILE" > /dev/null
    sudo chmod 0440 "$SUDOERS_FILE"
    echo "Passwordless sudo configured for '$USERNAME'."
fi

# Fetch public SSH keys from GitHub
SSH_DIR="/home/$USERNAME/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

sudo mkdir -p "$SSH_DIR"
sudo chmod 700 "$SSH_DIR"
sudo curl -s "https://github.com/$GITHUB_USER.keys" | sudo tee "$AUTHORIZED_KEYS" > /dev/null
sudo chmod 600 "$AUTHORIZED_KEYS"
sudo chown -R "$USERNAME:$USERNAME" "$SSH_DIR"

echo "SSH keys from GitHub user '$GITHUB_USER' installed for '$USERNAME'."