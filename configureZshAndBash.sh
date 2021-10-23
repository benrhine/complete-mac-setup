#!/bin/sh
# ==============================================================================================================
# Configure ZSH (and Bash Profile [Just in case])
# This will pull down a MASSIVE .bash_profile from https://github.com/benrhine/bashConfigWithGit and an even 
# more massive .zshrc from https://github.com/benrhine/zshenvWithGit
# ==============================================================================================================
echo "Switching to local repository directory ..."
cd $HOME/Repository

echo "Cloning bash profile with git script ..."
git clone https://github.com/benrhine/bashConfigWithGit.git

cd bashConfigWithGit
cp .bash_profile $HOME
cp .git-prompt.sh $HOME

echo "Switching to local repository directory ..."
cd $HOME/Repository

echo "Cloning zsh config with git script ..."
git clone https://github.com/benrhine/zshenvWithGit.git
cd zshenvWithGit
cp .zshrc $HOME

echo "ZSH and BASH configuration complete"