#!/bin/sh
# ==============================================================================================================
# Configure iTerm color profiles
# - https://github.com/mbadolato/iTerm2-Color-Schemes 
# ==============================================================================================================
echo "Switching to local repository directory ..."
cd $HOME/Repository

echo "Cloning terminal iTerm2-Color-Schemes ..."
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git

# Import all color schemes
echo "Installing iTerm color schemes ..."
cd iTerm2-Color-Schemes

tools/import-scheme.sh schemes/*

# Import all color schemes (verbose mode)
tools/import-scheme.sh -v schemes/*

# Import specific color schemes (quotations are needed for schemes with spaces in name)
tools/import-scheme.sh 'schemes/SpaceGray Eighties.itermcolors' # by file path
tools/import-scheme.sh 'SpaceGray Eighties'                     # by scheme name
tools/import-scheme.sh Molokai 'SpaceGray Eighties'             # import multiple

echo "iTerm color schemes installed"

# Make sure we return to the home directory - If we dont this causes an issue to where items are checked out to.
cd $HOME