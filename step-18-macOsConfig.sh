#!/bin/sh
# ==============================================================================================================
# Configure OSX
# - https://macos-defaults.com/dock/autohide.html
# - https://developer.apple.com/documentation/devicemanagement/dock
# ==============================================================================================================
echo "Configuring macOS..."

# Do not hide macOS Library
chflags nohidden ~/Library

# No hidden files - display all "dot" files by default
defaults write com.apple.finder AppleShowAllFiles YES

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Set accent color to Graphite
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

# Auto hide (Top) menu bar
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

#Turns on show Hard Disks, External disks, CDs, DVDs, and iPads, and Connected Servers

#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true;

#defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true;

#defaults write com.apple.finder ShowMountedServersOnDesktop -bool true;

#defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true;


#Shows Tab View

/usr/bin/defaults write com.apple.finder ShowTabView -bool true;

#Changes Finder to List View
#Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv'

/usr/bin/defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

#New Finder windows now opens in /Users/<username>

/usr/bin/defaults write com.apple.finder NewWindowTarget -string "PfHm"


# Restart Finder to pick up changes
killall Finder

echo "macOS configuration complete"
