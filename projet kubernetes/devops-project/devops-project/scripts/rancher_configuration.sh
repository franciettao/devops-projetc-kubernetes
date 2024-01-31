#!/bin/bash
# scripts/rancher_configuration.sh

# Script to configure Rancher

# Replace the following variables with your actual values
RANCHER_SERVER_URL="https://your-rancher-server-url.com"
RANCHER_ACCESS_KEY="your-access-key"
RANCHER_SECRET_KEY="your-secret-key"

# Install the Rancher CLI
curl -LJO https://github.com/rancher/cli/releases/download/v2.4.6/rancher-linux-amd64-v2.4.6.tar.gz
tar -zxvf rancher-linux-amd64-v2.4.6.tar.gz
sudo mv rancher-v2.4.6/rancher /usr/local/bin/

# Log in to Rancher
rancher login $RANCHER_SERVER_URL --token $RANCHER_ACCESS_KEY:$RANCHER_SECRET_KEY
