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

## Asking users' firefox release
read -p $'\e[32mFirefox or Firefox-esr? (firefox/firefox-esr) :\e[0m' FIREFOX_RELEASE

if [[ "${FIREFOX_RELEASE}" = "firefox" ]]; then
	PHOENIX_RELEASE="phoenix"
else
	PHOENIX_RELEASE="phoenix-esr"
fi


## Install Phoenix
echo_green_text "Adding celenity's OBS Repo to APT..."
echo 'deb http://download.opensuse.org/repositories/home:/celenity/Debian_12/ /' | \
	sudo tee /etc/apt/sources.list.d/home:celenity.list

echo_green_text "Adding celenity's GPG key..."
curl -fsSL https://download.opensuse.org/repositories/home:celenity/Debian_12/Release.key | \
	gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null

echo_green_text "Updating APT cache..."
sudo apt update || error_fn

echo_green_text "Installing Phoenix..."
sudo apt install "${PHOENIX_RELEASE}" || error_fn
echo

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#complete-coverage.\n"
