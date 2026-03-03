#!/bin/sh
# ==============================================================================================================
# Homebrew: Check for existing install, install if not present
# - https://brew.sh
# ==============================================================================================================
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Once install has been verified, update homebrew recipes
brew update

# Additional brew dependencies

brew tap hashicorp/tap
#brew tap pieces-app/pieces
brew install yt-dlp/taps/yt-dlp
# https://github.com/DomT4/homebrew-autoupdate
brew tap domt4/autoupdate
brew autoupdate start 43200 --upgrade --cleanup --immediate --sudo

echo "Homebrew install / update complete ..."
