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
# - bear: alternative to evernote but i dont really like
# - ollama-gui: nor sure this is valid
# ==============================================================================================================
UTIL_CASKS=(
    gas-mask
    geektool
    geekbench
    monolingual
    mysides
    sublime-text
    ubersicht
    vlc
    spek
    fnm
    yt-dlp/taps/yt-dlp
    tailscale
    wireguard-tools
    ollama
)

echo "Installing personal utilities ..."

for val in "${UTIL_CASKS[@]}"; do
    brew install $val || simpleError "$val"
done

brew services start ollama

# Create the require config for yt-dlp
echo "# Set Quality\n-f 'ba'\n\n# Always Extract Audio\n-x \n\n# Do not copy the mtime\n--no-mtime\n\n# Output Format\n--audio-format wav\n-o \"%(title)s.%(ext)s\"" > yt-dlp.conf

echo "Personal utilities installed"
