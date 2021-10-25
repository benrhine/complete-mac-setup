#!/bin/sh
# ==============================================================================================================
# Install SDKMAN!
# ==============================================================================================================
echo "Installing SDKMAN..."

curl -s "https://get.sdkman.io" | zsh

source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "SDKMAN installed the following version"
sdk version