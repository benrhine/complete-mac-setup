#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/
#
# Inspired by:
# - https://gist.github.com/codeinthehole/26b37efa67041e1307db
# - https://medium.com/@ivanaugustobd/your-terminal-can-be-much-much-more-productive-5256424658e8
# Get Time Stamp: Bash
# - https://newbedev.com/how-do-i-get-the-current-unix-time-in-milliseconds-in-bash
#
# - https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/AutomatetheUserInterface.html
# - https://www.macosxautomation.com/automator/folder-action/auto-approval-applet.html
# - https://macosxautomation.com/automator/security.html
# - https://scriptingosx.com/2020/09/avoiding-applescript-security-and-privacy-requests/
# - https://apple.stackexchange.com/questions/103621/run-applescript-from-bash-script
# - https://techviewleo.com/install-xcode-command-line-tools-macos/
# - https://www.freecodecamp.org/news/jazz-up-your-zsh-terminal-in-seven-steps-a-visual-guide-e81a8fd59a38/
# - https://oshyshkov.com/2020/12/20/my-shell-configuration-for-macos/ (terminal color config) **
# - https://www.thorsten-hans.com/5-types-of-zsh-aliases (zsh aliases)
# - https://github.com/matthieusb/zsh-sdkman
# - https://github.com/mosen/mysides
# - https://www.xmodulo.com/catch-handle-errors-bash.html
# - https://newbedev.com/is-there-a-try-catch-command-in-bash
# - https://medium.com/@Dylan.Wang/install-colorls-on-macos-mojave-10-14-6-970834959cdb - install colorls
# - https://github.com/mbadolato/iTerm2-Color-Schemes 
# - https://github.com/Powerlevel9k/powerlevel9k/wiki/Show-Off-Your-Config
# - https://github.com/Powerlevel9k/powerlevel9k/wiki/Stylizing-Your-Prompt#segment-color-customization

# ==============================================================================================================
# Configure host file after install use
# - https://winhelp2002.mvps.org/hosts.txt
# ==============================================================================================================


# ==============================================================================================================
# Simple error handler
# ==============================================================================================================
simpleError() {
    echo "$val: Failed to install ...\n"
}

export START_TIME=$(($(date +%s)))
echo "Starting bootstrapping at $START_TIME"
# ==============================================================================================================
# Handle Script Options
# ==============================================================================================================
while getopts u:l:f:g:b:m:v:gm:dev: flag
do
    case "${flag}" in
        u) utilities=${OPTARG};;
        l) languageSupport=${OPTARG};;
        f) fonts=${OPTARG};;
        g) includeVcs=${OPTARG};;
        b) browsers=${OPTARG};;
        m) misc=${OPTARG};;
        v) vpns=${OPTARG};;
        gm) games=${OPTARG};;
        p) pythonInstall=${OPTARG};;
        r) rubyInstall=${OPTARG};;
        dev) devInstall=${OPTARG};;
    esac
done

if [ -z "$utilities" ]; then utilities="TRUE"; fi
if [ -z "$languageSupport" ]; then languageSupport="TRUE"; fi
if [ -z "$fonts" ]; then fonts="TRUE"; fi
if [ -z "$includeVcs" ]; then includeVcs="TRUE"; fi
if [ -z "$browsers" ]; then browsers="TRUE"; fi
if [ -z "$misc" ]; then misc="TRUE"; fi
if [ -z "$vpns" ]; then vpns="TRUE"; fi
if [ -z "$games" ]; then games="TRUE"; fi
if [ -z "$pythonInstall" ]; then pythonInstall="TRUE"; fi
if [ -z "$rubyInstall" ]; then rubyInstall="TRUE"; fi
if [ -z "$devInstall" ]; then devInstall="TRUE"; fi

echo "Include command line utilities: $utilities";
echo "Include language support: $languageSupport";
echo "Include additional fonts: $fonts";
echo "Include git: $includeVcs";
echo "Include additional browsers: $browsers";
echo "Include media and general applications: $misc";
echo "Include vpns: $vpns";
echo "Include games and game stores: $games";
echo "Include python support: $pythonInstall";
echo "Include ruby support: $rubyInstall";
# ==============================================================================================================
# Xcode Install - non interactive
# This still requires interaction - have solved this by allowing brew to install xcode in the following step. 
# For details see:
# - https://www.freecodecamp.org/news/install-xcode-command-line-tools/
# ==============================================================================================================
# echo "Installing Xcode ... DO NOT TOUCH!!! Responses are scripted for you."

# xcode-select --install

# status=$?
# if [ $status -eq 1 ]; then
#     echo "General error"
# elif [ $status -eq 2 ]; then
#     echo "Misuse of shell builtins"
# elif [ $status -eq 126 ]; then
#     echo "Command invoked cannot execute"
# elif [ $status -eq 128 ]; then
#     echo "Invalid argument"
# fi

# # TODO this needs a try catch and currently cant figure out how
# # TODO this has a second ask we need to reutnr on
# sleep 1
# osascript <<EOD
#   tell application "System Events"
#     tell process "Install Command Line Developer Tools"
#       keystroke return
#       click button "Agree" of window "License Agreement"
#       tell menu bar 1
#         click button "Done"
#       end tell
#     end tell
#   end tell
# EOD

# echo "Xcode install complete"
# ==============================================================================================================
# Homebrew: Check for existing install, install if not present
# ==============================================================================================================
if test ! $(which brew); then
    echo "Installing homebrew..."
    # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
brew update

echo "Homebrew install / update complete ..."
# Install GNU core utilities (those that come with OS X are outdated)
# brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed
brew install gnu-tar
brew install gnu-indent
brew install gnu-which
# brew install gnu-grep

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

# ==============================================================================================================
# Unix / Linux command line utilities to install
# Somce of these may be unnecessary but they are small and its nice to just get everything installed
# Removed from list:
#   ssh-copy-id
# ==============================================================================================================
UTILITIES=(
    ag
    ack
    autoconf
    automake
    fd
    ffind
    ffmpeg
    fpp
    gettext
    gifsicle
    graphviz
    hub
    imagemagick
    jq
    libjpeg
    libmemcached
    pkg-config
    rename
    terminal-notifier
    the_silver_searcher
    tmux
    tree
    vim
    watchman
    wget
    z
)

if [ $utilities == TRUE ]; then
    echo "Installing utilitiy packages..."
    for val in "${UTILITIES[@]}"; do
        brew install $val || simpleError "$val"
    done
else
    echo "Excluding utility packages..."
fi

# Currently this is unused
UTILITIES_WITH_ADDITIONAL_SETUP_STEPS=(
    memcached
)
# ==============================================================================================================
# Scripting language support for local environment
# ==============================================================================================================
LANGUAGE_SUPPORT=(
    awscli
    aws-console
    go
    markdown
    node
    npm
    postgresql
    python
    python3
    pypy
    rabbitmq
    ruby
    yarn
)

if [ $languageSupport == TRUE ]; then
    echo "Installing language support packages..."
    for val in "${LANGUAGE_SUPPORT[@]}"; do
        brew install $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Vcs support
# ==============================================================================================================
VCS=(
    git
    mercurial
    subversion
)

if [ $includeVcs == TRUE ]; then
    echo "Installing language support packages..."
    for val in "${VCS[@]}"; do
        brew install $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Clean up brew installs
# ==============================================================================================================
echo "Cleaning up brew installs ..."
brew cleanup
# ==============================================================================================================
# Misc applications we want installed
# ==============================================================================================================
UTIL_CASKS=(
    blackhole-16ch
    gas-mask
    geektool
    gpg-suite
    mysides
    spectacle
    sublime-text
    ubersicht
    vlc
)

if [ $utilities == TRUE ]; then
    echo "Installing utilitiy casks ..."
    for val in "${UTIL_CASKS[@]}"; do
        brew install $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# General / Personal applications we want installed
# Extras I want sometime
# - flux (sort of replaced by native mac functionality)
# - folding-at-home
# ==============================================================================================================
GENERAL_CASKS=(
    evernote
    google-drive
    mixed-in-key
    obs
    parallels
    rambox
    sublime-text
    transmit
    twitch
)

if [ $misc == TRUE ]; then
    echo "Installing general / personal apps..."
    for val in "${GENERAL_CASKS[@]}"; do
        brew install --cask $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Install Browsers
# ==============================================================================================================
BROWSERS=(
    brave-browser
    firefox
    google-chrome
)

if [ $browsers == TRUE ]; then
    echo "Installing browsers..."
    for val in "${BROWSERS[@]}"; do
        brew install --cask $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Install VPNs
# ==============================================================================================================
VPN=(
    nordvpn
    zerotier-one
)

if [ $vpns == TRUE ]; then
    echo "Installing vpns..."
    for val in "${VPN[@]}"; do
        brew install --cask $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Install Developer Tools
# ==============================================================================================================
DEVELOP=(
    docker
    google-cloud-sdk
    intellij-idea-ce
    intellij-idea
    iterm2
    macvim
    postman
    slack
    vagrant
)

if [ $devInstall == TRUE ]; then
    echo "Installing developer tools..."
    for val in "${DEVELOP[@]}"; do
        brew install --cask $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Install Games
# ==============================================================================================================
GAMES=(
    epic-games
    minecraft
    openemu
    parsec
    steam
    retroarch-metal
)

if [ $games == TRUE ]; then
    echo "Installing game apps..."
    for val in "${GAMES[@]}"; do
        brew install --cask $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Install Additional Fonts
# - font-liberation-mono
# - font-liberation-sans
# ==============================================================================================================
if [ $fonts == TRUE ]; then
    echo "Installing additional fonts..."
    brew tap homebrew/cask-fonts
    FONTS=(
        font-hack-nerd-font
        font-inconsolata
        font-roboto
        font-clear-sans
        font-anonymous-pro
        font-dejavu-sans-mono-for-powerline
        font-droid-sans-mono-for-powerline
        font-meslo-lg
        font-input
        font-inconsolata
        font-inconsolata-for-powerline
        font-liberation-mono-for-powerline
        font-meslo-lg
        font-nixie-one
        font-office-code-pro
        font-pt-mono
        font-raleway
        font-source-code-pro
        font-source-code-pro-for-powerline
        font-source-sans-pro
        font-ubuntu 
        font-ubuntu-mono-powerline
        font-covered-by-your-grace
        font-hack
        font-league-gothic
        font-rambla
        font-share-tech
    )
    for val in "${FONTS[@]}"; do
        brew install --cask $val || simpleError "$val"
    done
else
    echo "Excluding additional fonts..."
fi
# ==============================================================================================================
# Install Python
# ==============================================================================================================
if [ $pythonInstall == TRUE ]; then
    echo "Installing Python packages..."
    PYTHON_PACKAGES=(
        ipython
        virtualenv
        virtualenvwrapper
    )
    
    for val in "${PYTHON_PACKAGES[@]}"; do
        sudo pip3 install $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Install Ruby Gems
# - cocoapods
# - colorls - this should install
#   - https://medium.com/@Dylan.Wang/install-colorls-on-macos-mojave-10-14-6-970834959cdb
# ==============================================================================================================
if [ $rubyInstall == TRUE ]; then
    echo "Installing Ruby gems"
    RUBY_GEMS=(
        bundler
        filewatcher
    )
    
    for val in "${RUBY_GEMS[@]}"; do
        sudo gem install $val || simpleError "$val"
    done
else
    echo "Excluding language support packages..."
fi
# ==============================================================================================================
# Install Npm
# ==============================================================================================================
echo "Installing global npm packages..."
npm install marked -g
# ==============================================================================================================
# Configure OSX
# - https://macos-defaults.com/dock/autohide.html
# - https://developer.apple.com/documentation/devicemanagement/dock
# ==============================================================================================================
echo "Configuring OSX..."

# Do not hide MacOS Library
chflags nohidden ~/Library

# No hidden files - display all "dot" files by default
defaults write com.apple.finder AppleShowAllFiles YES

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Set accent color
defaults write NSGlobalDomain AppleAccentColor -int -1

# Display breadcrumbs to file at the bottom of the finder window
defaults write com.apple.finder ShowPathbar -bool true

# Display status bar - dont actually remember what this does
defaults write com.apple.finder ShowStatusBar -bool true

# Set custom location to save screenshots to
mkdir $HOME/Documents/screenshots
defaults write com.apple.screencapture location "$HOME/Documents/screenshots"

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Auto hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true 

# Auto hide dock
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-time-modifier" -float "0.5"

# Dock Size
defaults write com.apple.dock "tilesize" -int "36"

# Enable Magnification
defaults write com.apple.dock "magnification" -bool "true"

# Magnification Size
defaults write com.apple.dock "largesize" -int "96"

# Double click window bar
defaults write com.apple.dock "dblclickbehavior" -string "minimize"

# Minimize app into icon
defaults write com.apple.dock "minimize-to-application" -bool "true"

# Restart dock to apply settings
killall Dock

# Enable tap-to-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" scroll
#defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# TODO figure out how to set window button color

# ==============================================================================================================
# https://itectec.com/askdifferent/macos-is-it-possible-to-set-magic-trackpad-option-via-terminal/
# Trackpad: enable tap to click for this user and for the login screen
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Trackpad: swipe between pages with three fingers
#defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1
# ==============================================================================================================

# ==============================================================================================================
# Create Additional Directories
# ==============================================================================================================
echo "Creating folder structure..."
[[ ! -d Repository ]] && mkdir Repository
[[ ! -d Tools ]] && mkdir Tools

mysides add example file:///$HOME/Repository
mysides add example file:///$HOME/Tools

# ==============================================================================================================
# Install OH MY ZSH
# ==============================================================================================================
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ==============================================================================================================
# Install OH MY ZSH Plugins
# ==============================================================================================================
cd ${HOME}/.oh-my-zsh

#chmod -r 775 custom

cd custom
mkdir plugins
mkdir themes

cd plugins

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

git clone https://github.com/zsh-users/zsh-autosuggestions.git

git clone https://github.com/matthieusb/zsh-sdkman.git

cd ../themes

# git clone https://github.com/bhilburn/powerlevel9k.git "${ZSH_CUSTOM}/themes/powerlevel9k"
git clone https://github.com/bhilburn/powerlevel9k.git
# git clone https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
git clone https://github.com/romkatv/powerlevel10k.git
# ==============================================================================================================
# Configure Bash Profile (Just in case) and zshrc
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
echo "Switching to local repository directory ..."
cd $HOME/Repository
echo "Cloning terminal iTerm2-Color-Schemes ..."
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git
cd iTerm2-Color-Schemes
# Import all color schemes
echo "Installing iTerm color schemes ..."
tools/import-scheme.sh schemes/*

# Import all color schemes (verbose mode)
tools/import-scheme.sh -v schemes/*

# Import specific color schemes (quotations are needed for schemes with spaces in name)
tools/import-scheme.sh 'schemes/SpaceGray Eighties.itermcolors' # by file path
tools/import-scheme.sh 'SpaceGray Eighties'                     # by scheme name
tools/import-scheme.sh Molokai 'SpaceGray Eighties'             # import multiple
# ==============================================================================================================
# Install SDKMAN!
# ==============================================================================================================
echo "Installing SDKMAN..."
curl -s "https://get.sdkman.io" | zsh
source "$HOME/.sdkman/bin/sdkman-init.sh"
echo "SDKMAN version"
sdk version

sdk install maven
sdk install gradle
sdk install java

echo $M2_HOME
mvn --version

echo $GRADLE_HOME
gradle --version

echo $JAVA_HOME
java --version


echo "Bootstrapping complete, final step ..."
export END_TIME=$(($(date +%s)))
echo "Total time taken to install (in seconds): ($END_TIME - $START_TIME)"











