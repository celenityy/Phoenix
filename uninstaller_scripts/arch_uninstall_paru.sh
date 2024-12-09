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


## Uninstall Phoenix
echo_green_text "Removing phoenix.cfg..."
sudo rm -f /usr/lib/firefox/phoenix.cfg || error_fn
echo

echo_green_text "Removing phoenix.js..."
sudo rm -f /etc/firefox/defaults/pref/phoenix.js || error_fn
echo

echo_green_text "Removing legacy mozilla.cfg if installed..."
sudo rm -f /usr/lib/firefox/mozilla.cfg || error_fn
echo

echo_green_text "Removing legacy local-settings.js if installed..."
sudo rm -f /usr/lib/firefox/defaults/pref/local-settings.js || error_fn
echo

echo_green_text "Uninstalling phoenix-policies..."
paru -Rcns phoenix-policies || error_fn
echo

echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"
