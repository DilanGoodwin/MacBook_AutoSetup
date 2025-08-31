#!/bin/bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Open Applications
open /Applications/iTerm.app
open /Applications/Rectangle Pro.app

# Kill Applications
osascript -e 'tell application "System Preferences" to quit'
osascript -e 'tell application "iTerm2" to quit'
osascript -e 'tell application "Rectangle Pro" to quit'

# General Settings
defaults write -globalDomain AppleActionOnDoubleClick -string "None"
defaults write -globalDomain AppleInterfaceStyle -string "Dark"
defaults write -globalDomain NSQuitAlwaysKeepWindows -int 1
defaults write -globalDomain NSTableViewDefaultSizeMode -int 1
defaults write -globalDomain AppleMenuBarVisibleInFullscreen -int 1

# Window Management
windowManager="$HOME/Library/Preferences/com.apple.WindowManager.plist"
plutil -replace AppWindowGroupBehaviour -integer 1 $windowManager
plutil -replace AppWindowGroupingBehaviour -integer 1 $windowManager
plutil -replace AutoHide -integer 1 $windowManager
plutil -replace EnableStandardClickToShowDesktop -integer 0 $windowManager
plutil -replace EnableTilingByEdgeDrag -integer 0 $windowManager
plutil -replace EnableTilingOptionAccelerator -integer 0 $windowManager
plutil -replace EnableTopTilingByEdgeDrag -integer 0 $windowManager
plutil -replace HideDesktop -integer 1 $windowManager
plutil -replace StageManagerHideWidgets -integer 0 $windowManager
plutil -replace StandardHideWidgets -integer 0 $windowManager

# Dock
dock="$HOME/Library/Preferences/com.apple.dock.plist"
plutil -replace "show-recents" -integer 0 $dock
plutil -replace tilesize -integer 16 $dock

# iTerm2 Settings

# RectangePro Settings
