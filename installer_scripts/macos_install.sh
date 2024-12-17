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
echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://codeberg.org/celenity/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update && brew upgrade --force --verbose || error_fn
echo

echo -e ""
echo -e "${brown}Where is your installation of Firefox located?${coloroff}";
echo -e "${brown}Your options are:${coloroff}";
echo -e "${blue}system${coloroff} - ${green}/Applications/Firefox.app${coloroff}";
echo -e "${red}user${coloroff}  - ${green}~/Applications/Firefox.app${coloroff}";
read -p 'Enter your selection: ' LOCATION
case ${LOCATION} in
	"system" | "System" | "SYSTEM")
		echo_green_text "Installing phoenix-osx package..."
		brew install phoenix-osx || error_fn
		echo
		;;
	"user" | "User" | "USER")
		echo_green_text "Installing phoenix-osx-user package..."
		brew install phoenix-osx-user || error_fn
		echo
		;;
esac
;;

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#complete-coverage.\n"
