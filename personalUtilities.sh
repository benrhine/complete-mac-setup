#!/bin/sh
# ==============================================================================================================
# Personal Utilities
# - blackhole-16ch: (https://github.com/ExistentialAudio/BlackHole) Virtual sound card - allows audio routing
# - gas-mask: (https://github.com/2ndalpha/gasmask) Easily edit host file
# - geektool: (https://www.tynsoe.org/geektool) Mac theming tool
# - gpg-suite:
# - mysides: (https://github.com/mosen/mysides) Terminal modification of Finder side bar
# - spectacle: (https://www.spectacleapp.com) This app is no longer maintained
# - sublime-text: (https://www.sublimetext.com) Great text editor
# - ubersicht: (https://tracesof.net/uebersicht/) Great mac theming tool 
# - vlc: Plays almost every kind of media
# - monolingual: remove extra language files
# ==============================================================================================================
UTIL_CASKS=(
    blackhole-16ch
    gas-mask
    geektool
    gpg-suite
    monolingual
    mysides
    sublime-text
    ubersicht
    vlc
)

echo "Installing personal utilities ..."

for val in "${UTIL_CASKS[@]}"; do
    brew install $val || simpleError "$val"
done

echo "Personal utilities installed"