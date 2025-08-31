#!/bin/bash

osascript -e 'tell application "System Preferences" to quit'
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# General Settings
defaults write -globalDomain AppleActionOnDoubleClick -string "None"
defaults write -globalDomain AppleInterfaceStyle -string "Dark"
defaults write -globalDomain NSQuitAlwaysKeepWindows -int 1
defaults write -globalDomain NSTableViewDefaultSizeMode -int 1

# Terminal Settings
defaults write com.apple.Terminal "NSWindow Frame TTWindow Basic" -string "0 656 570 371 0 0 1800 1029"

# Window Management
defaults write com.apple.WindowManager AppWindowGroupBehaviour -int 1
defaults write com.apple.WindowManager AutoHide -int 1
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -int 0
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -int 0
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -int 0
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -int 0
defaults write com.apple.WindowManager HideDesktop -int 1
defaults write com.apple.WindowManager StageManagerHideWidgets -int 0
defaults write com.apple.WindowManager StandardHideWidgets -int 0

# Dock
defaults write com.apple.dock launchanim -int 0
defaults write com.apple.dock "minimize-to-application" -int 1
defaults write com.apple.dock "show-recents" -int 0
defaults write com.apple.dock tilesize -int 16

