#!/bin/sh
# ==============================================================================================================
# Configure additional system actions
# ==============================================================================================================

cp resources/mail-to-md.workflow ~/Library/Services/mail-to-md.workflow

cd "$ICLOUD_DRIVE"
pwd

mkdir obsidian-vaults

cd obsidian-vaults

git clone git@github.com:benrhine/obsidian-vaults.git

cd $HOME

# Configure qmd

echo '' >> ~/.zshrc
echo '# fnm (Fast Node Manager)' >> ~/.zshrc
echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> ~/.zshrc

eval "$(fnm env --shell bash)"
fnm install 22
fnm use 22
fnm default 22
node --version   # Should show v22.x.x

npm install -g @tobilu/qmd

qmd --version

eval "$(fnm env --shell bash)" && fnm use 22 && qmd --version



