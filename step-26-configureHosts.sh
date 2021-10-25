#!/bin/sh
# ==============================================================================================================
# Build Custom Hosts file
# - Allow for ad blocking by default
# ==============================================================================================================

cd $HOME

# Backup existing host file
sudo cp /etc/hosts /etc/hosts.bak

echo "Downloading a good hosts file for ad blocking ..."

# Download a good host file
wget https://winhelp2002.mvps.org/hosts.txt -O dlHosts

echo "Downlading personal hosts list to speed up page load times ..."

wget https://gist.githubusercontent.com/benrhine/c8001df9b9e8872b73f6461fa76087b3/raw/be0f328a61cedb3c77151c63912bd9c66c7d57e7/speedy-hosts -O speedyHosts

echo "Merging existing host file with new hosts ..."

cat /etc/hosts speedyHosts dlHosts > tmpHosts 

echo "Setting new hosts file ..."

sudo mv tmpHosts /etc/hosts

echo "Cleaning up home directory ..."
rm dlHosts