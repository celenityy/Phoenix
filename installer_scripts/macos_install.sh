#!/bin/zsh

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

## Downloaded files save in /tmp
cd /tmp

## Colours
blue='\e[1;34m'
brown='\e[0;33m'
coloroff='\e[0m' # Colour off
cyan='\e[1;36m'
gray='\e[1;30m'
green='\e[0;32m'
purple='\e[1;35m'
red='\e[1;31m'
yellow='\e[1;33m'

## Download and run initialization script
initialize_phoenix() {
	wget -nv $1
	echo
	echo
	sudo bash $2
}

## Scripts are here
URL="https://codeberg.org/celenity/Phoenix/raw/branch/dev/installer_scripts/macos"

## Scripts file
SCRIPT=("phoenix-initialize-system.sh"
		"phoenix-initialize-user.sh")

## Install Phoenix
echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://codeberg.org/celenity/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update && brew upgrade --force --verbose || error_fn
echo

echo_green_text "Installing phoenix-wip package..."
brew install phoenix-wip || error_fn
echo

echo_green_text "Downloading phoenix-apply.sh..."
wget -nv https://codeberg.org/celenity/Phoenix/raw/branch/dev/macos/Library/celenity/Phoenix/phoenix-apply.sh || error_fn
echo

echo_green_text "Changing permissions of phoenix-apply.sh to 744..."
sudo /bin/chmod -v 744 phoenix-apply.sh || error_fn
echo

echo_green_text "Creating /Library/celenity/Phoenix directory..."
sudo /bin/mkdir -v -p /Library/celenity/Phoenix || error_fn
echo

echo_green_text "Changing permissions of Library/celenity/Phoenix to 744..."
sudo /bin/chmod -v 744 /Library/celenity/Phoenix || error_fn
echo

echo_green_text "Copying phoenix-apply.sh to /Library/celenity/Phoenix/phoenix-apply.sh..."
sudo /bin/cp phoenix-apply.sh /Library/celenity/Phoenix/phoenix-apply.sh || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.apply.plist..."
wget -nv https://codeberg.org/celenity/Phoenix/raw/branch/dev/macos/Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.apply.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.phoenix.apply.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.apply.plist to /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist..."
sudo /bin/cp dev.celenity.phoenix.apply.plist /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.apply.plist..."
sudo /bin/launchctl load -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
echo

echo_green_text "Downloading phoenix-bootstrap.js..."
wget -nv https://codeberg.org/celenity/Phoenix/raw/branch/dev/macos/defaults/pref/phoenix-bootstrap.js || error_fn
echo

echo_green_text "Changing permissions of phoenix-bootstrap.js to 644..."
sudo /bin/chmod -v 644 phoenix-bootstrap.js || error_fn
echo

echo_green_text "Downloading phoenix-bootstrap.cfg..."
wget -nv https://codeberg.org/celenity/Phoenix/raw/branch/dev/macos/phoenix-bootstrap.cfg || error_fn
echo

echo_green_text "Changing permissions of phoenix-bootstrap.cfg to 644..."
sudo /bin/chmod -v 644 phoenix-bootstrap.cfg || error_fn
echo

echo -e ""
echo -e "${brown}Where is your installation of Firefox located?${coloroff}";
echo -e "${brown}Your options are:${coloroff}";
echo -e "${blue}1. system${coloroff} - ${green}/Applications/Firefox.app${coloroff}";
echo -e "${red}2. user${coloroff}  - ${green}~/Applications/Firefox.app${coloroff}";
read -p 'Enter your selection: ' LOCATION
case ${LOCATION} in
	"system" | "System" | "SYSTEM" | 1)
        TARGET_SCRIPT="${SCRIPT[0]}"
		;;

	"user" | "User" | "USER" | 2)
		TARGET_SCRIPT="${SCRIPT[1]}"
		;;
esac
;;

## Download and run choosen initializion script
initialize_phoenix "${URL}"/"${TARGET_SCRIPT}" "${TARGET_SCRIPT}"
