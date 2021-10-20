#!/usr/bin/env bash
# ==============================================================================================================
# Updates: Update core utilities on macOS to the latest versions (those that come with OS X are outdated)
#
# Notes:
# - findutils: Installs GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
# - bash: Installs Bash 4
# 
# Not currently included:
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

# ==============================================================================================================
# When updating the above you will see they generate the messages below asking you to update the PATH linkage to
# use the updated utilities. Feel free to relink them yourself or if you are running this script set in its
# entirety they will be automatically relinked when the script installs the .zshrc from
# https://github.com/benrhine/zshenvWithGit
# ==============================================================================================================

# GNU "which" has been installed as "gwhich".
# If you need to use it as "which", you can add a "gnubin" directory
# to your PATH from your bashrc like:

# PATH="/usr/local/opt/gnu-which/libexec/gnubin:$PATH"

# GNU "indent" has been installed as "gindent".
# If you need to use it as "indent", you can add a "gnubin" directory
# to your PATH from your bashrc like:

# PATH="/usr/local/opt/gnu-indent/libexec/gnubin:$PATH"

# GNU "tar" has been installed as "gtar".
# If you need to use it as "tar", you can add a "gnubin" directory
# to your PATH from your bashrc like:

# PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"


# GNU "sed" has been installed as "gsed".
# If you need to use it as "sed", you can add a "gnubin" directory
# to your PATH from your bashrc like:

# PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"


# Commands also provided by macOS and the commands dir, dircolors, vdir have been installed with the prefix "g".
# If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"