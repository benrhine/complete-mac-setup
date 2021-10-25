#!/bin/sh
# ==============================================================================================================
# Configure ZSH (and Bash Profile [Just in case])
# This will pull down a MASSIVE .bash_profile from https://github.com/benrhine/bashConfigWithGit and an even 
# more massive .zshrc from https://github.com/benrhine/zshenvWithGit
# ==============================================================================================================
echo "Switching to local repository directory ..."

if [ -d "$HOME/Repository" ]; then
    cd $HOME/Repository
    pwd
else
	echo "\n*************************************************************************"
	echo "WARNING - THIS SHOULD NOT HAVE HAPPENED"
    echo "Error: Directory $HOME/Repository does not exists. Trying to create ..."
    echo "*************************************************************************\n"
    mkdir $HOME/Repository && cd $HOME/Repository
fi

if [ ! -d "$HOME/Repository" ]; then
	echo "\n*************************************************************************"
	echo "WARNING - THIS SHOULD NOT HAVE HAPPENED"
    echo "Error: Directory $HOME/Repository creation failed again ... exiting"
    echo "*************************************************************************\n"
	exit 9999 # die with error code 9999
fi

## why did this line not print?
echo "Cloning bash profile with git script ..."
git clone https://github.com/benrhine/bashConfigWithGit.git

if [ -d "$HOME/Repository/bashConfigWithGit" ]; then
    cd bashConfigWithGit
	cp .bash_profile $HOME
	cp .git-prompt.sh $HOME
else
	echo "Failed to clone bashConfigWithGit"
fi

echo "Switching to local repository directory ..."
cd $HOME/Repository
pwd

echo "Cloning zsh config with git script ..."
git clone https://github.com/benrhine/zshenvWithGit.git

if [ -d "$HOME/Repository/zshenvWithGit" ]; then
    cd zshenvWithGit
	cp .zshrc $HOME
else
	echo "Failed to clone zshenvWithGit"
fi

echo "ZSH and BASH configuration complete"