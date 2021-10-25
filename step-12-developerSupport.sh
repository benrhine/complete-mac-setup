#!/bin/sh
# ==============================================================================================================
# Install Developer Tools
# ==============================================================================================================
DEVELOP=(
    docker
    intellij-idea-ce
    intellij-idea
    iterm2
    macvim
    postman
    slack
    vagrant
)

echo "Installing developer tools..."

for val in "${DEVELOP[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Developer tools installed"