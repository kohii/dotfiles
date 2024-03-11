#!/bin/bash

# Keyboard
defaults write -g InitialKeyRepeat -int 13 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
## Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# Doc
## Hide recent apps
defaults write com.apple.dock "show-recents" -bool false

# Finder
## Show extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
## Show path bar
defaults write com.apple.finder ShowPathbar -bool true
## Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
## Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

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

# Feedback
## Disable crach report
defaults write com.apple.CrashReporter DialogType -string "none"

