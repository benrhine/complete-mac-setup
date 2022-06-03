#!/bin/sh
# ==============================================================================================================
# Configure OSX
# - https://macos-defaults.com/dock/autohide.html
# - https://developer.apple.com/documentation/devicemanagement/dock
# - https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# ==============================================================================================================
echo "Configuring macOS..."

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

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
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

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

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

#Turns on show Hard Disks, External disks, CDs, DVDs, and iPads, and Connected Servers

#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true;

#defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true;

#defaults write com.apple.finder ShowMountedServersOnDesktop -bool true;

#defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true;

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


#Shows Tab View

/usr/bin/defaults write com.apple.finder ShowTabView -bool true;

#Changes Finder to List View
#Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv'

/usr/bin/defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

#New Finder windows now opens in /Users/<username>

/usr/bin/defaults write com.apple.finder NewWindowTarget -string "PfHm"


# Restart Finder to pick up changes
killall Finder

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true



echo "macOS configuration complete"
