#!/bin/sh

# System Preferences > Desktop & Screen Saver > Screen Saver > Hot Corners: Bottom-right with no modifier opens Mission Control
defaults write com.apple.dock wvous-br-corner -int 2 
defaults write com.apple.dock wvous-br-modifier -int 0

# System Preferences > Dock > Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# System Preferences > Dock > Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# System Preferences > Mission Control > Automatically rearrange Spaces based on most recent use (disable)
defaults write com.apple.dock mru-spaces -bool false

echo 'Go to System Preferences > Sound and show volume in the Menu Bar.'

# System Preferences > Trackpad > Tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# System Preferences > Accessibility > Pointer Control > Mouse & Trackpad > Trackpad Options: Enable dragging, Without drag lock
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true

# System Preferences > Keyboard > Text > Correct spelling automatically (disable)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# System Preferences > Keyboard > Text > Capitalize words automatically (disable)
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# System Preferences > Keyboard > Text > Add period with double-space (disable)
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo 'Go to System Preferences > Keyboard and remove auto-correct items. Optionally, disable smart quotes.'

# Finder > Preferences > General > New Finder windows show: User folder
defaults write com.apple.finder NewWindowTarget -string 'PfHm'
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Finder > Preferences > Sidebar > Recent Tags (disable)
defaults write com.apple.finder ShowRecentTags -bool false

# Finder > Preferences > Advanced > Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder > Preferences > Advanced > Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder > Preferences > Advanced > When performing a search: Search the Current Folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder > View > As List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder > View > Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder > View > Status Bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show hidden files by default (Command+Shift+.)
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show absolute path in Finder's title bar.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo 'Go to Finder > Preferences and configure the Tags and Sidebar tabs. Then, rearrange the sidebar items.'

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# "disable" Writing of .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Key Repeat speed
defaults write NSGlobalDomain KeyRepeat -int 2

# "delay" Until Repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Full Keyboard Access: In windows and dialogs, press Tab to move keyboard focus between:
# "All controls"
# defaults write NSGlobalDomain AppleKeyboardUIMode -int 2
# sudo defaults write -g AppleKeyboardUIMode

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Terminal: Only use UTF-8
defaults write com.apple.terminal StringEncodings -array 4

# iTunes: Don't automatically sync connected devices
# defaults write com.apple.itunes dontAutomaticallySyncIPods -bool true

# Safari: Don't offer to save passwords.
defaults write com.apple.Safari AutoFillPasswords -bool false

# Disk Utility: Show All Devices
defaults write com.apple.DiskUtility SidebarShowAllDevices -bool true

# Time Machine: Prevent from prompting to use new hard drives as backup volume
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

for app in "Dock" "Finder"; do
    killall "${app}" > /dev/null 2>&1
done

echo 'Done. Review settings and reboot.'
echo 'To set the hostname:'
echo '  # scutil --set HostName <fully qualified host name>'
echo '  # scutil --set LocalHostName <host name and MDNS domain if not .local>'
echo '  # scutil --set ComputerName <friendly host name>'
echo '  $ dscacheutil -flushcache'
