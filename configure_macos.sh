#!/bin/bash

# Keyboard
defaults write -g InitialKeyRepeat -int 13 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
## Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2
## Use F1, F2, etc. keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
## Enable key repeating
defaults write -g ApplePressAndHoldEnabled -bool false

# Dock
## Hide recent apps
defaults write com.apple.dock "show-recents" -bool false
## Disable auto-hide
defaults write com.apple.dock autohide -bool false

# Finder
## Show extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
## Show path bar
defaults write com.apple.finder ShowPathbar -bool true
## Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
## Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
## Don't create .DS_Store files for network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
## Don't create .DS_Store files for USB volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
## Show  all files
defaults write com.apple.finder AppleShowAllFiles -bool true
## Show $HOME in new Finder window
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
## Put directories in front of sort by name when selecting sort by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
## Restart Finder
killall Finder

# Trackpad
## Cursor speed
defaults write -g com.apple.trackpad.scaling 3

# Mouse
## Cursor speed
defaults write -g com.apple.mouse.scaling 2
## Scroll speed
defaults write -g com.apple.scrollwheel.scaling 4

# Screenshot
## Disable shadow in screenshots
defaults write com.apple.screencapture "disable-shadow" -bool true

## Set screenshot directory
if [[ ! -d "$HOME/Desktop/screenshots" ]]; then
    mkdir -p "$HOME/Desktop/screenshots"
fi

defaults write com.apple.screencapture "location" -string "~/Desktop/screenshots"

# Feedback
## Disable crach report
defaults write com.apple.CrashReporter DialogType -string "none"


# Others
## Auto install purchased apps
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

## Open Kitty via OpenInTerminal-Lite
defaults write wang.jianing.app.OpenInTerminal-Lite LiteDefaultTerminal kitty

