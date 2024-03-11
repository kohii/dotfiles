#!/bin/bash

# Keyboard
defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# Doc
## Hide recent apps
defaults write com.apple.dock "show-recents" -bool "false"

# Finder
## Show extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
## Show path bar
defaults write com.apple.finder ShowPathbar -bool "true"

# Trackpad
## Cursor speed
defaults write -g com.apple.trackpad.scaling 3

# Mouse
## Cursor speed
defaults write -g com.apple.mouse.scaling 2
## Scroll speed
defaults write -g com.apple.scrollwheel.scaling 4

