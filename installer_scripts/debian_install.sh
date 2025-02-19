#! /usr/bin/env bash


## Downloaded files save in /tmp for moving
cd /tmp

## Colours
blue='\e[1;34m'
brown='\e[0;33m'
coloroff='\e[0m' # Colour off
cyan='\e[1;36m'
gray='\e[1;30m'
green='\e[0;32m'
purple='\e[0;35m'
red='\e[1;31m'
yellow='\e[1;33m'


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


## Asking users' firefox release
echo -e "${yellow}phoenix package is for firefox and phoenix-esr package is for firefox-esr${coloroff}"
echo -e "${yellow}Please choose your Firefox release (Its name or its number)${coloroff}"
echo -e "${yellow}Your options are:${coloroff}"
echo -e "${blue}1. firefox${coloroff}     - ${green}Firefox${coloroff}"
echo -e "${red}2. firefox-esr${coloroff} - ${green}Firefox with Extended Support Release (Firefox-ESR)${coloroff}"
read -p 'Enter your selection: ' FIREFOX_RELEASE

case "${FIREFOX_RELEASE}" in
	"firefox" | "Firefox" | "FireFox" | "FIREFOX" | 1)
		PHOENIX_RELEASE="phoenix"
		;;

	"firefox-esr" | "FireFox-esr" | "FIREFOX-ESR" | 2)
		PHOENIX_RELEASE="phoenix-esr"
		;;

	*)
	echo -e "${red}Invalid option.${coloroff}"
	exit 1
esac

## Install Phoenix
echo_green_text "Adding celenity's OBS Repo to APT..."
echo 'deb http://download.opensuse.org/repositories/home:/celenity/Debian_12/ /' | \
	sudo tee /etc/apt/sources.list.d/home:celenity.list
echo

echo_green_text "Adding celenity's GPG key..."
wget -O-  https://download.opensuse.org/repositories/home:celenity/Debian_12/Release.key 2>/dev/null | \
	gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null
echo

echo_green_text "Updating APT cache..."
sudo apt update || error_fn
echo

echo_green_text "Installing Phoenix..."
sudo apt install "${PHOENIX_RELEASE}" || error_fn
echo

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#extended.\n"
