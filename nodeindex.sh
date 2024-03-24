#!/bin/bash

# Copy your systemd service file to /etc/systemd/system
sudo cp /opt/csye6225/nodeindex.service /etc/systemd/system/

# Reload systemd to pick up the changes
sudo systemctl daemon-reload

# Start the service
sudo systemctl start nodeindex.service

# Enable the service to start on boot
sudo systemctl enable nodeindex.service

# Check the status of the service
sudo systemctl status nodeindex.service
