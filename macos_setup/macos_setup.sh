#!/bin/sh

# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Utility functions
###############################################################################

# echo an error message before exiting
#trap 'echo "A required task failed. Stopping setup here."' EXIT

topic()
{
    printf "\n"
    printf "%s\n" "$1"
    printf "%.s=" $(seq 2 $(tput cols))
    printf "\n"
}

# start_task [Name of task]
# Example:
#   start_task "Get sudo permission."
start_task()
{
    printf '[ ] %s' "$1"
}

# prompt_for_key (no parameters)
prompt_for_key()
{
    printf '\r\33[2K> %s' "$1"
    read -n1 -s
}

# success [Name of task]
# Example:
#   success "Install Xcode."
success()
{
    printf '\r\33[2K[✓] %s\n' "$1"
}

# failure [Name of task] [Additional error message] ["yes" if required]
# Examples:
#   failure "Install Xcode." "Install started but Xcode isn't installed." "yes"
#   failure "Show path bar."
failure()
{
    printf '\r\33[2K[!] FAILED: %s %s\n' "$1" "$2"
    if [ "$3" = "yes" ]; then kill 0; fi
}

# run_task [Name of task] [Command to run] [Required?]
# Examples:
#   run_task "Get sudo permssion." "sudo -v" "yes"
#   run_task "Show path bar." \
#       "defaults write com.apple.finder ShowPathbar -bool true"
run_task()
{
    start_task "$1"
    echo "# $2" >>macos_setup.log
    $2 >>macos_setup.log 2>&1 && \
    success "$1" || failure "$1" "" "$3"
}

# todo [Name of task]
# Example:
#   todo "Go to System Preferences > Sound and show volume in the Menu Bar."
todo()
{
    printf '\r\33[2K[ ] TODO: %s %s\n' "$1" "$2"
}

# Setup script
###############################################################################

topic 'Get ready to run'
# =============================================================================
SUDO_USER=$(whoami)

echo  "> Enter sudo password if needed."

echo "# sudo -v" >>macos_setup.log
sudo -v >>macos_setup.log 2>&1 && \
success "Grant sudo permission" || failure "Grant sudo permission" "" "yes"

#run_task "Get sudo permission. " "sudo -v" "yes"

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do 
    sudo -n true 
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# -----------------------------------------------------------------------------

close_system_preferences()
{
    osascript -e 'tell application "System Preferences" to quit'
}

run_task "Close System Preferences." close_system_preferences

# -----------------------------------------------------------------------------

topic 'macOS Settings'
# =============================================================================

topic 'System Preferences > Desktop & Screen Saver > Screen Saver > Hot Corners'
# =============================================================================

run_task \
"Bottom-right -> Mission Control" \
"defaults write com.apple.dock wvous-br-corner -int 2"

run_task \
"Bottom-right -> No modifier" \
"defaults write com.apple.dock wvous-br-modifier -int 0"

topic 'System Preferences > Dock'
# =============================================================================

run_task \
"Minimize windows into application icon" \
"defaults write com.apple.dock minimize-to-application -bool true"

run_task \
"Automatically hide and show the Dock" \
"defaults write com.apple.dock autohide -bool true"

topic 'System Preferences > Mission Control'
# =============================================================================

run_task \
"Automatically rearrange Spaces based on most recent use (disable)" \
"defaults write com.apple.dock mru-spaces -bool false"

topic 'System Preferences > Sound'
# =============================================================================

todo "Go to System Preferences > Sound and show volume in the Menu Bar."

topic 'System Preferences > Trackpad'
# =============================================================================

tap_to_click()
{
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
}

run_task \
"Tap to click" \
tap_to_click

topic 'System Preferences > Accessibility > Pointer Control > Mouse & Trackpad > Trackpad Options'
# =============================================================================

enable_dragging()
{
    defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
}

run_task \
"Enable dragging, Without drag lock" \
enable_dragging

topic 'System Preferences > Keyboard > Text'
# =============================================================================

run_task \
"Correct spelling automatically (disable)" \
"defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false"

run_task \
"Capitalize words automatically (disable)" \
"defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false"

run_task \
"Add period with double-space (disable)" \
"defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false"

todo "Go to System Preferences > Keyboard and remove auto-correct items." 
todo "Optionally, disable smart quotes."

# This one is a mixed bag. Useful for forms in espanso, maybe other modals.
topic 'System Preferences > Keyboard > Shortcuts'
# =============================================================================

apple_keyboard_ui_mode()
{
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    defaults write -g AppleKeyboardUIMode
}

run_task \
"Enable full keyboard access with tab and shift-tab." \
apple_keyboard_ui_mode

topic 'Finder > Preferences'
# =============================================================================

new_folder_window_target()
{
    defaults write com.apple.finder NewWindowTarget -string 'PfHm'
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
}
run_task \
"General > New Finder windows show: User folder" \
new_folder_window_target

run_task \
"Sidebar > Recent Tags (disable)" \
"defaults write com.apple.finder ShowRecentTags -bool false"

run_task \
"Advanced > Show all filename extensions" \
"defaults write NSGlobalDomain AppleShowAllExtensions -bool true"

run_task \
"Advanced > Show warning before changing an extension (disable)" \
"defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false"

run_task \
"Advanced > When performing a search: Search the Current Folder" \
"defaults write com.apple.finder FXDefaultSearchScope -string "SCcf""

run_task \
"As List" \
"defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv""

run_task \
"Clear out view preferences in home directories" \
"find $HOME -name .DS_Store -delete"

todo "Go to Finder > Preferences and configure the Tags and Sidebar tabs. Then, rearrange the sidebar items."

topic 'Other Finder Settings'
# =============================================================================

run_task \
"Path Bar" \
"defaults write com.apple.finder ShowPathbar -bool true"

run_task \
"Status Bar" \
"defaults write com.apple.finder ShowStatusBar -bool true"

run_task \
"Show hidden files by default (Command+Shift+.)" \
"defaults write com.apple.finder AppleShowAllFiles -bool true"

run_task \
"Show absolute path in Finder's title bar." \
"defaults write com.apple.finder _FXShowPosixPathInTitle -bool true"

snap_to_grid()
{
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
}

run_task \
"Enable snap-to-grid for icons on the desktop and in other icon views." \
snap_to_grid

# Showing the item info in icon view is kind of cool, but not sure if I want it.
# show_item_info()
# {
#     # /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
#     # /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
#     # /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# }
# 
# run_task \
# "Show item info near icons on the desktop and in other icon views" \
# show_item_info

# I don't care if these are hidden, but some save dialogs don't show hidden
run_task \
"Show the ~/Library folder" \
"chflags nohidden $HOME/Library && xattr -d com.apple.FinderInfo ~/Library"

# Ditto.
run_task \
"Show the /Volumes folder" \
"sudo chflags nohidden /Volumes"

expand_get_info_panes()
{
    defaults write com.apple.finder FXInfoPanesExpanded -dict \
        General -bool true \
        OpenWith -bool true
        # Privileges -bool true
}

run_task \
"Expand General and Open with in Get Info form." \
expand_get_info_panes

topic 'Global macOS Settings'
# =============================================================================

run_task \
"Close windows when quitting an app system-wide." \
"defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false"

print_quit_when_finished()
{
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
}

# Automatically quit printer app once the print jobs complete
run_task \
"Automatically quit printer app once the print jobs complete" \
print_quit_when_finished

disable_DS_Store()
{
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
}

run_task \
"Don't write .DS_Store files on network and USB volumes" \
disable_DS_Store

run_task \
"Disable key press-and-hold. (Requires reboot)" \
"defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false"

run_task \
"Set key repeat speed. (Requires reboot)" \
"defaults write NSGlobalDomain KeyRepeat -int 1" # Default is 2 (30 ms)

run_task \
"Set delay until key repeat. (Requires reboot)" \
"defaults write NSGlobalDomain InitialKeyRepeat -int 15" # Default is 15 (225 ms)

run_task \
"Save to disk (not to iCloud) by default. (Probably requires reboot?)" \
"defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false"

# run_task \
# "Set the time zone to America/Chicago" \
# 'sudo systemsetup -settimezone "America/Chicago"'

# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
run_task \
"Enable subpixel font rendering on non-Apple LCDs." \
"defaults write NSGlobalDomain AppleFontSmoothing -int 1"

# Not sure if I need this.
# run_task \
# "Reveal IP address, hostname, OS, etc. when clicking the login form clock." \
# "sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName" 

# These seem to be available already.
# run_task \
# "Enable HiDPI display modes (requires restart)" \
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

topic 'App-Specific Settings'
# =============================================================================

run_task \
"Terminal: Use only UTF-8, not other encodings. (Requires Terminal restart)" \
"defaults write com.apple.terminal StringEncodings -array 4"

# Reference: https://security.stackexchange.com/a/47786/8918
run_task \
"Terminal: Enable Secure Keyboard Entry." \
"defaults write com.apple.terminal SecureKeyboardEntry -bool true"

run_task \
"Terminal: Disable the annoying line marks." \
"defaults write com.apple.Terminal ShowLineMarks -bool false"

# Pretty sure this one doesn't exist anymore.
# run_task \
# "iTunes: Don't automatically sync connected devices" \
# "defaults write com.apple.itunes dontAutomaticallySyncIPods -bool true"

# The following don't seem to work anymore. Test and replace todo items.
run_task \
"Show the full URL in the address bar (note: this still hides the scheme)" \
"defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true"

safari_search_settings()
{
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true
}

run_task \
"Safari: Don’t send search queries to Apple" \
"safari_search_settings"

run_task \
"Safari: Don't offer to save passwords." \
"defaults write com.apple.Safari AutoFillPasswords -bool false"

# todo "In Safari Preferences, disable AutoFill > User names and passwords."
# todo "In Safari Preferences, select Advanced > Show full website address."
# todo "In Safari Preferences, select Advanced > Show Develop menu in menu bar."

run_task \
"Disk Utility: Show All Devices." \
"defaults write com.apple.DiskUtility SidebarShowAllDevices -bool true"

# I'm not sure if this is needed anymore.
# run_task \
# "Time Machine: Don't prompt to use new hard drives as backup volume." \
# "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true"

run_task \
"TextEdit: Make new documents plain text-only by default." \
"defaults write com.apple.TextEdit RichText -bool false"

textedit_use_utf8()
{
    defaults write com.apple.TextEdit PlainTextEncoding -int 4
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
}

run_task \
"TextEdit: Open and save files as UTF-8 in TextEdit" \
textedit_use_utf8

# Doesn't work anymore in Monterey and later.
# run_task \
# "Disable the Big Sur-style inline window title in many applications." \
# "defaults write -g NSWindowSupportsAutomaticInlineTitle -bool false"

reset_affected_apps()
{
    start_task "Reset affected apps."

    for app in "Dock" "Finder" "Safari" "Disk Utility" "TextEdit"; do
        killall "${app}" >>macos_setup.log 2>&1
    done

    success "Reset affected apps."
}

reset_affected_apps

# -----------------------------------------------------------------------------

topic 'Xcode'
# =============================================================================

check_for_xcode() 
{
    if type xcode-select > /dev/null 2>&1 && 
       xpath=$( xcode-select --print-path 2> /dev/null ) &&
       test -d "${xpath}" && test -x "${xpath}"
    then
        return
    fi

    false
}

# N.B. this is a subshell function with () not {}, so variables are local scope
install_xcode()
(
    start_task "Install Xcode."

    install_started=false

    while true; do
        if check_for_xcode; then
            success "Install Xcode."
            break
        fi

        if $install_started; then
            failure "Install Xcode." "Install was started but Xcode isn't installed." "yes"
            break
        fi

        xcode-select --install >>macos_setup.log 2>&1 && install_started=true
        prompt_for_key "When you're done installing Xcode, press any key to continue."
    done
)

install_xcode

# -----------------------------------------------------------------------------

# run_task "Accept Xcode license." "xcodebuild -license accept" "yes"

# -----------------------------------------------------------------------------

topic 'Homebrew'
# =============================================================================

install_brew()
(
    task="Install Homebrew."
    start_task "$task"

    install_started=false

    while true; do
        if type brew > /dev/null 2>&1; then
            success "$task"
            break
        fi

        if $install_started; then
            failure "$task" "Install was started but Homebrew available." "yes"
            break
        fi

        install_started=true
        NONINTERACTIVE=1 \
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
            >>macos_setup.log 2>&1

        eval "$(/opt/homebrew/bin/brew shellenv 2>>macos_setup.log)"
    done
)

install_brew

# -----------------------------------------------------------------------------

topic 'Applications'
# =============================================================================

install_brew_bundles()
(
    for file in "./Brewfile.basics" "$HOME/Brewfile"; do
        run_task "Install $file" "sudo -u $SUDO_USER brew bundle install --file $file"
    done
)

install_brew_bundles

# -----------------------------------------------------------------------------

todo "Install Mac App Store apps."

# -----------------------------------------------------------------------------


topic 'Wrap Up'
# =============================================================================

todo "Set hostname: # scutil --set HostName <fully qualified host name>"
todo "Set MDNS name:  # scutil --set LocalHostName <host name and MDNS domain if not .local>"
todo "Set friendly host name: # scutil --set ComputerName <friendly host name>"
todo "Flush directory service: $ dscacheutil -flushcache"
todo "Reboot."

# Install mas https://github.com/mas-cli/mas
# Use mas to install purchased apps from the app store (amphetamine, wireguard)

#unset task
