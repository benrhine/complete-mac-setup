#!/usr/bin/env bash
# ==============================================================================================================
# Install Python
# ==============================================================================================================
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)

echo "Installing Python packages..."

for val in "${PYTHON_PACKAGES[@]}"; do
    sudo pip3 install $val || simpleError "$val"
done

echo "Python packages installed"