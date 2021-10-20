#!/usr/bin/env bash
# ==============================================================================================================
# Install OH MY ZSH Plugins
# - https://github.com/zsh-users/zsh-syntax-highlighting
# - https://github.com/zsh-users/zsh-autosuggestions
# - https://github.com/matthieusb/zsh-sdkman
# - https://github.com/bhilburn/powerlevel9k (depricated in favor of 10k)
# - https://github.com/romkatv/powerlevel10k - 9k is a little bit easier to configure in my opinion and 10k supports
#   all of 9k's configuration options
# - https://github.com/Powerlevel9k/powerlevel9k/wiki/Show-Off-Your-Config
# - https://github.com/Powerlevel9k/powerlevel9k/wiki/Stylizing-Your-Prompt#segment-color-customization
#
# It should be possible to simplify the syntax of the below as follows ...
# - git clone https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
# Unfortunately when attempting to do so the clone fails claiming the custom directory is read only. Even when
# inspecting the directory and seeing that it is NOT read only and attempting additional chmod and chown commands
# still result in an error claiming the directory structure is locked, thus resulting in the bloated syntax below.
# ==============================================================================================================
cd ${HOME}/.oh-my-zsh/custom/plugins

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

git clone https://github.com/zsh-users/zsh-autosuggestions.git

git clone https://github.com/matthieusb/zsh-sdkman.git

cd ../themes

git clone https://github.com/bhilburn/powerlevel9k.git

git clone https://github.com/romkatv/powerlevel10k.git