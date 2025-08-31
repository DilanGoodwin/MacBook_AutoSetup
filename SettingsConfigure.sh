#!/bin/bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Kill Applications
osascript -e 'tell application "System Preferences" to quit'

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

# Finder
finder="$HOME/Library/Preferences/com.apple.finder.plist"
plutil -replace DesktopViewSettings.IconViewSettings.axTextSize -integer 11 $finder
plutil -replace DesktopViewSettings.IconViewSettings.iconSize -integer 56 $finder
plutil -replace DesktopViewSettings.IconViewSettings.textSize -integer 11 $finder 

# iTerm2 Settings
term="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
plutil -replace EnableDivisionView -integer 0 $term
plutil -replace HapticFeedbackForEsc -integer 0 $term
plutil -replace HideMenuBarInFullscreen -integer 1 $term
plutil -replace HidTabNumber -integer 1 $term
plutil -replace "Normal Font" -string "BlexMonoNF 12" $term
plutil -replace ShowFullScreenTabBar -integer 0 $term
plutil -replace SoundForEsc -integer 0 $term
plutil -replace StatusBarPosition -integer 0 $term
plutil -replace StretchTabsToFillBar -integer 0 $term
plutil -replace TabViewType -integer 1 $term
plutil -replace TabsHaveCloseButton -integer 0 $term
plutil -replace VisualIndicatorForEsc -integer 0 $term
plutil -replace WindowNumber -integer 0 $term

# RectangePro Settings


# Reboot
# Reboot is needed for setting changes to take affect
sudo reboot
