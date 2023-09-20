#!/bin/bash

# Directory to hold SSH keys for the sfaiz user
SSH_DIR="$HOME/.ssh"

# SSH key files
PRIVATE_KEY="$SSH_DIR/id_rsa"
PUBLIC_KEY="$SSH_DIR/id_rsa.pub"

# Check if SSH directory exists
if [ ! -d "$SSH_DIR" ]; then
    mkdir -p "$SSH_DIR"
    chmod 700 "$SSH_DIR"
fi

# Generate SSH keys if they don't exist
if [ ! -f "$PRIVATE_KEY" ] || [ ! -f "$PUBLIC_KEY" ]; then
    ssh-keygen -t rsa -b 4096 -f "$PRIVATE_KEY" -N ""
    echo "New SSH key pair generated."
else
    echo "Existing SSH key pair found."
fi

# Output the public key
echo "Copy the following SSH public key and add it to your GitHub account:"
cat "$PUBLIC_KEY"

