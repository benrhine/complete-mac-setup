#!/bin/sh
# ==============================================================================================================
# General / Personal applications we want installed
# Extras I want sometime
# - folding-at-home
# - evernote
# - rambox
# - utm - free virtualization
# - veracrypt

# ==============================================================================================================
APPLICATIONS=(
    google-drive
    mixed-in-key
    obs
    parallels
    transmit
    twitch
    flux
    zoom
    xld
    vuescan
    rekordbox
    openaudible
    obsidian
    istat-menus
    balenaetcher
    ableton-live-suite
    hiddenbar
    ollama-app
)

echo "Installing general / personal apps..."

for val in "${APPLICATIONS[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Peronal applications installed"
