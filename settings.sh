# Always show extensions in finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# List view as default view
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# Keep folders on top
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

killall Finder

# Keyboard

# Disable Apple's Press and hold
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2


# Dock

# Autohide
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "autohide-delay" -int "0"
defaults write com.apple.dock "autohide-time-modifier" -float "0.15"

# Minimize to application
defaults write com.apple.dock "minimize-to-application" -bool "true"

# Icons size
defaults write com.apple.dock "tilesize" -int "36"

# Prevent resize
defaults write com.apple.dock "size-immutable" -bool "true"

# Don't show recents
defaults write com.apple.dock "show-recents" -bool "false"

# Mission Control

# Don't rearrange spaces
defaults write com.apple.dock "mru-spaces" -bool "false"

killall Dock
