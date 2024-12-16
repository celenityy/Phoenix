#! /usr/bin/env bash


## Functions
echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo -e "\033[31mPlease report this (with the output message) to https://phoenix.celenity.dev/issues\033[0m"
	echo
	exit 1
}


## Upgrade Phoenix
echo_green_text "Removing legacy phoenix.cfg..."
sudo rm -f /Applications/Firefox.app/Contents/Resources/phoenix.cfg || error_fn
echo

echo_green_text "Removing legacy phoenix.js..."
sudo rm -f /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js || error_fn
echo

echo_green_text "Removing legacy mozilla.cfg if installed..."
sudo rm -f /Applications/Firefox.app/Contents/Resources/mozilla.cfg || error_fn
echo

echo_green_text "Removing legacy local-settings.js if installed..."
sudo rm -f /Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js || error_fn
echo

echo_green_text "Unloading ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist..."
sudo launchctl unload -w  ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist || error_fn
echo

echo_green_text "Removing ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist..."
sudo rm -f ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist || error_fn
echo

echo_green_text "Removing /usr/local/sbin/update_policies_phoenix.sh..."
sudo rm -f /usr/local/sbin/update_policies_phoenix.sh || error_fn
echo

echo_green_text "Removing legacy policies.json..."
sudo rm -f /Applications/Firefox.app/Contents/Resources/distribution/policies.json || error_fn
echo

echo_green_text "Uninstalling legacy phoenix-policies..."
brew uninstall phoenix-policies || error_fn
echo

echo_green_text "Removing legacy Phoenix-Policies-macOS Tap from Homebrew if installed..."
brew untap celenity/Phoenix-Policies-macOS || error_fn
echo

echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://codeberg.org/celenity/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update || error_fn
echo

echo_green_text "Installing phoenix package..."
brew install phoenix-osx || error_fn
echo

echo_green_text "Thank you for upgrading Phoenix! Enjoy :)"
