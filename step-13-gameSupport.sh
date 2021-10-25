#!/bin/sh
# ==============================================================================================================
# Install game support: This installs game stores and support for game streaming and emulation
# ==============================================================================================================
GAMES=(
    epic-games
    gog-galaxy
    minecraft
    moonlight
    openemu
    parsec
    steam
    retroarch-metal
)

echo "Installing game support..."

for val in "${GAMES[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Game support installed"