#! /bin/bash

sudo apt-get install apt-transport-https curl

# Modify your sources list:
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

# Get the Microsoft signing key:
curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

# Install the CLI:
sudo apt-get update && sudo apt-get install azure-cli