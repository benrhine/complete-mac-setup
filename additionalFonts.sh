#!/usr/bin/env bash
# ==============================================================================================================
# Install Additional Fonts:
#
# Some font installs require SVN to be installed. SVN install can be found in the vcsSupport.sh file.
#
# Failed installs:
# - font-liberation-mono: could not be found
# - font-liberation-sans: could not be found
# ==============================================================================================================
FONTS=(
    font-hack-nerd-font
    font-inconsolata
    font-roboto
    font-clear-sans
    font-anonymous-pro
    font-dejavu-sans-mono-for-powerline
    font-droid-sans-mono-for-powerline
    font-meslo-lg
    font-input
    font-inconsolata
    font-inconsolata-for-powerline
    font-liberation-mono-for-powerline
    font-meslo-lg
    font-nixie-one
    font-office-code-pro
    font-pt-mono
    font-raleway
    font-source-code-pro
    font-source-code-pro-for-powerline
    font-source-sans-pro
    font-ubuntu 
    font-ubuntu-mono-powerline
    font-covered-by-your-grace
    font-hack
    font-league-gothic
    font-rambla
    font-share-tech
)

echo "Installing additional fonts..."

brew tap homebrew/cask-fonts

for val in "${FONTS[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Additional fonts installed"