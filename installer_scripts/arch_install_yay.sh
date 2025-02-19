#! /usr/bin/env bash


## Downloaded files save in /tmp for moving
cd /tmp


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


## Install Phoenix
echo -e ""
echo_green_text "Is Firefox installed as a standard package, or as a Flatpak?";
echo_green_text "Your options are:";
echo_red_text "1. Standard package";
echo_green_text "2. Flatpak (System)";
read -p 'Please enter your selection: ' LOCATION
case ${LOCATION} in
	"standard" | "Standard" | "STANDARD" | 1)
        echo_green_text "Installing phoenix-arch from the AUR..."
		yay -S phoenix-arch || error_fn
		echo
		;;

	"flatpak" | "Flatpak" | "FLATPAK" | 2)
		echo_green_text "Installing phoenix-flatpak from the AUR..."
		yay -S phoenix-flatpak || error_fn
		echo
		;;
esac

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#extended.\n"
