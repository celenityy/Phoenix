#! /usr/bin/env bash


echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}


echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo
	exit 1
}

echo_green_text "Removing mozilla.cfg"
sudo rm -f /snap/firefox/current/usr/lib/firefox/mozilla.cfg || error_fn
echo


echo_green_text "Removing local-settings.js"
sudo rm -f /snap/firefox/current/usr/lib/firefox/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Uninstalling phoenix-policies"
sudo apt remove phoenix-policies || error_fn
echo

echo_green_text "Updating APT cache"
sudo apt update || error_fn
echo


echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"
