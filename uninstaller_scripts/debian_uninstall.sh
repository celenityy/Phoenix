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
	echo -e "\033[31mPlease report error (with output message) to https://codeberg.org/celenity/Phoenix/issues\033[0m"
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
sudo apt remove phoenix-policies || error_fn
echo

read -p  $'\e[32mDo you want remove Prebuilt MPR Repo? [Y/n] \e[0m' RESULT
echo

case ${RESULT} in

		"y" | "yes" | "YES" | "Y")
			echo_green_text "Removing Prebuilt MPR Repo"
			sudo rm -v /etc/apt/sources.list.d/prebuilt-mpr.list || error_fn
			echo

			echo_green_text "Removing GPG keyof Prebuilt MPR Repo"
			sudo rm -v /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg || error_fn
			echo
			;;
		
		"n" | "no" | "N" | "NO")
			;;
esac

echo_green_text "Updating APT cache"
sudo apt update || error_fn
echo

echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(. Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"
