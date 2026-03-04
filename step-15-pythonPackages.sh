#!/bin/sh
# ==============================================================================================================
# Install Python
# - pyvis
# - networkx
# The two above are required for /recall graph skill and not sure if they will install the same with pipx
# - https://github.com/ArtemXTech/personal-os-skills/blob/main/docs/memory-skills-setup.md
# these are items for work with claude
# ==============================================================================================================
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
    markdownify
    networkx
    pyvis
)

echo "Installing Python packages..."

for val in "${PYTHON_PACKAGES[@]}"; do
    sudo -H pipx install $val || simpleError "$val"
done

pipx ensurepath
pipx completions

echo "Python packages installed"