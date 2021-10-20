#!/usr/bin/env bash
# ==============================================================================================================
# Install Ruby Gems
# - cocoapods
# - colorls - this should install
#   - https://medium.com/@Dylan.Wang/install-colorls-on-macos-mojave-10-14-6-970834959cdb
# ==============================================================================================================
RUBY_GEMS=(
    bundler
    filewatcher
)

echo "Installing Ruby Gems"

for val in "${RUBY_GEMS[@]}"; do
    sudo gem install $val || simpleError "$val"
done

echo "Ruby Gems installed"