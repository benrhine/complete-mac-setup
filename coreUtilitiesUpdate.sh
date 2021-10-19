#!/usr/bin/env bash
# ==============================================================================================================
# Updates: Update core utilities on macOS to the latest versions (those that come with OS X are outdated)
#
# Notes:
# - findutils: Installs GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
# - bash: Installs Bash 4
# 
# Not currently included
# - brew tap homebrew/dupes
# ==============================================================================================================
UPDATES=(
	bash
	coreutils
	findutils
	gnu-sed
	gnu-tar
	gnu-indent
	gnu-which
	grep
)

echo "Updating outdated core packages ..."

for val in "${UPDATES[@]}"; do
    brew install $val || simpleError "$val"
done

echo "Core packages updated"