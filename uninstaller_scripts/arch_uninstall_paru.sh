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
echo -e ""
echo_green_text "Is Firefox installed as a standard package, or as a Flatpak?";
echo_green_text "Your options are:";
echo_red_text "1. Standard package";
echo_green_text "2. Flatpak (System)";
read -p 'Please enter your selection: ' LOCATION
case ${LOCATION} in
	"standard" | "Standard" | "STANDARD" | 1)
        echo_green_text "Uninstalling phoenix-arch..."
		paru -Rcns phoenix-arch || error_fn
		echo
		;;

	"flatpak" | "Flatpak" | "FLATPAK" | 2)
		echo_green_text "Uninstalling phoenix-flatpak..."
		paru -Rcns phoenix-flatpak || error_fn
		echo
		;;
esac

echo_green_text "Removing `phoenix-desktop.js` from `/usr/lib/firefox` if present..."
sudo rm -f /usr/lib/firefox/defaults/pref/phoenix-desktop.js || error_fn
echo

echo_green_text "Removing legacy `phoenix.js` from `/etc/firefox` if present..."
sudo rm -f /etc/firefox/defaults/pref/phoenix.js || error_fn
echo
 
echo_green_text "Removing legacy `phoenix.js` from `/usr/lib/firefox` if present..."
sudo rm -f /usr/lib/firefox/defaults/pref/phoenix.js || error_fn
echo

echo_green_text "Removing `policies.json` from `/usr/lib/firefox` if present..."
sudo rm -f /usr/lib/firefox/distribution/policies.json || error_fn
echo

echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"
