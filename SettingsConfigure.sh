#!/bin/bash

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Kill Applications
osascript -e 'tell application "System Preferences" to quit'

printf "Settings Configurator\n"

printf "Copying Settings Before Changes\n"
save_location="$HOME/Documents/SettingsBackups"
mkdir -p $save_location
defaults read > $save_location/before_changes

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

# iTerm2 Settings
printf "iTerm2 Settings\n"
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
plutil -replace PreventEscapeSequenceFromClearingHistory -integer 0 $term

# RectangePro Settings
printf "Rectange Pro Settings\n"
rect="$HOME/Library/Preferences/com.knollsoft.Hookshot.plist"

plutil -replace SUEnableAutomaticChecks -integer 0 $rect
plutil -replace NSNavPanelExpandedStateForSaveMode -integer 1 $rect
plutil -replace SUEnableAutomaticChecks -integer 1 $rect
plutil -replace applyGapToEdges -integer 2 $rect
plutil -replace doubleClickTitleBar -integer 3 $rect
plutil -replace hideMenuBarIcon -integer 0 $rect
plutil -replace hookshotStatusIcon -integer 3 $rect
plutil -replace stashEnabled -integer 1 $rect
plutil -replace stashInMenu -integer 1 $rect
plutil -replace stashTabs -integer 1 $rect

defaults read > $save_location/after_changes

# Reboot
# Reboot is needed for setting changes to take affect
sudo reboot
