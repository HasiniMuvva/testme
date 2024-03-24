#!/bin/bash

# This script installs Node.js on CentOS


# Install Node.js
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -


sudo yum install -y nodejs

# Verify installation
node --version
npm --version
