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
	echo
	exit 1
}


## Find Release codename. For example, bookworm is codename of Debian 12
Release_CodeName=$(grep 'VERSION_CODENAME' /etc/os-release | cut -d'=' -f2)

if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	echo
	exit 1
fi


## Install Phoenix
echo_green_text "Downloading phoenix.cfg..."
wget -nv https://phoenix.celenity.dev/phoenix.cfg || error_fn
echo

echo_green_text "Moving phoenix.cfg to /usr/lib/firefox/phoenix.cfg..."
sudo mv -v phoenix.cfg /usr/lib/firefox/phoenix.cfg || error_fn
echo

echo_green_text "Downloading phoenix.js..."
wget -nv https://phoenix.celenity.dev/defaults/pref/phoenix.js || error_fn
echo

echo_green_text "Creating /etc/firefox/defaults/pref directory..."
sudo mkdir -v -p /etc/firefox/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /etc/firefox/defaults/pref to 655..."
sudo chmod -v 655 /etc/firefox/defaults/pref || error_fn
echo

echo_green_text "Moving phoenix.js to /etc/firefox/defaults/pref/phoenix.js..."
sudo mv -v phoenix.js /etc/firefox/defaults/pref/phoenix.js || error_fn
echo

echo_green_text "Adding Prebuilt MPR repo if not already installed..."
wget -O- -nv 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | \
	gpg --dearmor | \
	sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null

echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg]" \ 
	"https://proget.makedeb.org prebuilt-mpr ${Release_CodeName}" | \
	sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
echo

echo_green_text "Updating APT cache..."
sudo apt update || error_fn
echo

echo_green_text "Installing Makedeb if not already installed..."
sudo apt install makedeb || error_fn
echo

echo_green_text "Installing git if not already installed..."
sudo apt install git || error_fn
echo

echo_green_text "Cloning Mist..."
git clone "https://mpr.makedeb.org/mist.git" || error_fn
echo

echo_green_text "Building & Installing Mist..."
cd mist/
makedeb -s -i
echo

echo_green_text "Installing phoenix-policies package..."
mist phoenix-policies || error_fn
echo

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#complete-coverage.\n"
