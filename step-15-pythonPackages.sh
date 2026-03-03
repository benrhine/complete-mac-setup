#!/bin/sh
# ==============================================================================================================
# Install Python
# ==============================================================================================================
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
    markdownify
)

echo "Installing Python packages..."

for val in "${PYTHON_PACKAGES[@]}"; do
    sudo -H pipx install $val || simpleError "$val"
done

pipx ensurepath
pipx completions

echo "Python packages installed"