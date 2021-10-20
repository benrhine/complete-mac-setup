#!/usr/bin/env bash
# ==============================================================================================================
# Install Browsers
# ==============================================================================================================
BROWSERS=(
    brave-browser
    firefox
    google-chrome
)

echo "Installing browsers..."

for val in "${BROWSERS[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Browsers installed"