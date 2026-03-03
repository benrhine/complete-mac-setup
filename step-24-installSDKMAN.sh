#!/bin/sh
# ==============================================================================================================
# Install SDKMAN!
# - https://sdkman.io/install/
# ==============================================================================================================
echo "Installing SDKMAN..."

curl -s "https://get.sdkman.io" | bash

source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "SDKMAN installed the following version"
sdk version