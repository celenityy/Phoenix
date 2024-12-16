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
sudo rm -f /usr/lib64/firefox/phoenix.cfg || error_fn
echo

echo_green_text "Removing legacy phoenix.js..."
sudo rm -f /etc/firefox/defaults/pref/phoenix.js || error_fn
echo

echo_green_text "Removing legacy mozilla.cfg if installed..."
sudo rm -f /usr/lib64/firefox/mozilla.cfg || error_fn
echo

echo_green_text "Removing legacy local-settings.js if installed..."
sudo rm -f /usr/lib64/firefox/defaults/pref/local-settings.js || error_fn
echo

echo_green_text "Uninstalling legacy phoenix-policies..."
sudo dnf remove phoenix-policies || error_fn
echo

echo_green_text "Removing legacy Phoenix-Policies COPR Repo..."
sudo dnf copr remove celenity/phoenix-policies || error_fn
echo

echo_green_text "Adding celenity's COPR Repo to DNF..."
sudo dnf copr enable celenity/copr || error_fn
echo

echo_green_text "Updating DNF cache..."
sudo dnf update --refresh || error_fn
echo

echo_green_text "Installing phoenix package..."
sudo dnf install phoenix || error_fn
echo

echo_green_text "Thank you for upgrading Phoenix! Enjoy :)"
