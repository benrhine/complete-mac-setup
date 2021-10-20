#!/usr/bin/env bash
# ==============================================================================================================
# VPN Support
# ==============================================================================================================
VPN=(
    nordvpn
    zerotier-one
)

echo "Installing vpn support ..."

for val in "${VPN[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Vpn support installed"