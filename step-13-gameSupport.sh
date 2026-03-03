#!/bin/sh
# ==============================================================================================================
# Install game support: This installs game stores and support for game streaming and emulation
# - crossover
# - moonlight
# - epic-games
# - gog-galaxy
# - minecraft
# - parsec
# - steam
# ==============================================================================================================
GAMES=(
    openemu
    retroarch-metal
    pcsx2
    outfox
)

echo "Installing game support..."

for val in "${GAMES[@]}"; do
    brew install --cask $val || simpleError "$val"
done

brew install rpcs3

echo "Game support installed"