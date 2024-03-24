#!/bin/bash


# exit if any command fails
set -e

# Add Ops Agent repository
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install