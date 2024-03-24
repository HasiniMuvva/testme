#!/bin/bash

# Commands executed as root before switching to csye6225 user

# Update system packages and install unzip and zip
# sudo dnf update -y
sudo dnf install -y unzip zip

# Create csye6225 group (force if it already exists)
sudo groupadd -f csye6225

# Create 6225 user with no login shell
sudo useradd -g csye6225 -s /usr/sbin/nologin -d /opt/csye6225 -m csye6225

# Copy application artifact to /opt directory
# Replace "/temp/application.zip" with the actual path to your application artifact
sudo cp /tmp/application.zip /opt/application.zip

# Unzip application to /opt directory
sudo unzip /opt/application.zip -d /opt/csye6225

# Change ownership and permissions of application directory to csye6225:csye6225
sudo chown -R csye6225:csye6225 /opt/csye6225
sudo chmod -R 755 /opt/csye6225
# Switch to csye6225 user and execute commands as that user
sudo -u csye6225 bash <<'EOF'
# Commands to be executed as csye6225 user
# Navigate to the application directory
cd /opt/csye6225
touch .env
EOF
