#!/bin/sh
# ==============================================================================================================
# General / Personal applications we want installed
# Extras I want sometime
# - flux (sort of replaced by native mac functionality)
# - folding-at-home
# ==============================================================================================================
APPLICATIONS=(
    evernote
    google-drive
    mixed-in-key
    obs
    parallels
    rambox
    transmit
    twitch
)

echo "Installing general / personal apps..."

for val in "${APPLICATIONS[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Peronal applications installed"
