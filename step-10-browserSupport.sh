#!/bin/sh
# ==============================================================================================================
# Install Browsers
# - shift - paid browser
# ==============================================================================================================
BROWSERS=(
    brave-browser
    firefox
    google-chrome
    arc
)

echo "Installing browsers..."

for val in "${BROWSERS[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Browsers installed"