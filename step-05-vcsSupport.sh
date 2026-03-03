#!/bin/sh
# ==============================================================================================================
# Vcs support
# - https://sourabhbajaj.com/mac-setup/Git
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

git --version

which git

echo "Configuring Git ..."

git config --global user.name "Ben Rhine"
git config --global user.email "rhine.ben@gmail.com"

# I have this turned off as I do not have it set in my current gitconfig
#git config --global credential.helper osxkeychain

echo "Git configuration complete"

# THIS ASSUMES A BRAND NEW MACHINE / FRESH SETUP - THERE SHOULD BE NO SSH KEYS
echo "Configuring SSH ..."

# Lists the files in your .ssh directory, if they exist
ls -al ~/.ssh

# Creates a new ssh key, using the provided email as a label
ssh-keygen -t rsa -C "rhine.ben@gmail.com"

eval "$(ssh-agent -s)"

# Set the path to your .ssh/config file
config_file=~/.ssh/config

# Add the lines to the config file
echo "Host *" >> $config_file
echo "  AddKeysToAgent yes" >> $config_file
echo "  UseKeychain yes" >> $config_file
echo "  IdentityFile ~/.ssh/id_rsa" >> $config_file

# Make sure the changes take effect
source $config_file

ssh-add -K ~/.ssh/id_rsa

echo "YOU MUST NOW EXECUTE 'pbcopy < ~/.ssh/id_rsa.pub' TO COPY YOUR KEY AND SET IT UP IN GITHUB"

echo "SSH configuration complete"