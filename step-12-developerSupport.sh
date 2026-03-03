#!/bin/sh
# ==============================================================================================================
# Install Developer Tools
# - antigravity
# - vagrant
# - macvim
# ==============================================================================================================
DEVELOP=(
    docker
    intellij-idea-ce
    intellij-idea
    iterm2
    antigravity
    postman
    slack
    claude-code
    cherry-studio
    discord
    github
)

echo "Installing developer tools..."

for val in "${DEVELOP[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "Developer tools installed"