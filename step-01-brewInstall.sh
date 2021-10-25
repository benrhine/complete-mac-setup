#!/bin/sh
# ==============================================================================================================
# Homebrew: Check for existing install, install if not present
# - https://brew.sh
# ==============================================================================================================
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Once install has been verified, update homebrew recipes
brew update

echo "Homebrew install / update complete ..."