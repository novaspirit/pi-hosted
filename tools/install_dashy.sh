#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directory..."
sudo mkdir -p /portainer/Files/AppData/Config/Dashy || error "Failed to create Dashy folder!"

# Dashy reads its dashboard from conf.yml inside the /app/user-data directory in the container
# Create minimal config if none exists yet
if [ ! -f /portainer/Files/AppData/Config/Dashy/conf.yml ]; then
  echo "Creating a starter Dashy conf.yml"
  sudo tee /portainer/Files/AppData/Config/Dashy/conf.yml > /dev/null <<'EOF'
---
pageInfo:
  title: My Dashboard
sections:
  - name: Getting Started
    items:
      - title: Dashy Docs
        description: Configuration options for your dashboard
        icon: favicon
        url: https://dashy.to/docs
EOF
fi

# Dashy runs as unprivilaged node user (uid/gid 1000). So user-data directory needs to be owned by 1000:1000
echo "Setting permissions..."
sudo chown -R 1000:1000 /portainer/Files/AppData/Config/Dashy || error "Failed to set permissions for Dashy data!"

echo "Setup complete. You can now install Dashy using the App Template."
