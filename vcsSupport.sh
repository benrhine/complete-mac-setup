#!/usr/bin/env bash
# ==============================================================================================================
# Vcs support
# ==============================================================================================================
VCS=(
    git
    mercurial
    subversion
)

echo "Installing VCS packages..."

for val in "${VCS[@]}"; do
    brew install $val || simpleError "$val"
done

echo "VCS support installed"