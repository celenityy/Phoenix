#!/bin/zsh

sudo rm -f /Applications/Firefox.app/Contents/Resources/mozilla.cfg

sudo rm -f /Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js

sudo launchctl unload -w  ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist

sudo rm -f ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist

sudo rm -f /usr/local/sbin/update_policies_phoenix.sh

sudo rm -f /Applications/Firefox.app/Contents/Resources/distribution/policies.json

brew uninstall phoenix-policies

brew untap celenity/Phoenix-Policies-macOS

brew update

printf "Thanks for giving Phoenix a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"