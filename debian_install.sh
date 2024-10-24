#! /usr/bin/env bash


cd /tmp


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


## Release codename. For example, bookworm is codename of Debian 12
Release_CodeName=$(grep 'VERSION_CODENAME' /etc/os-release | cut -d'=' -f2)


if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	echo
	exit 1
fi


echo_green_text "Downloading mozilla.cfg..."
wget -nv https://phoenix.celenity.dev/mozilla.cfg || error_fn
echo


echo_green_text "Moving mozilla.cfg to /usr/lib/firefox/mozilla.cfg..."
sudo mv -v mozilla.cfg /usr/lib/firefox/mozilla.cfg || error_fn
echo


echo_green_text "Downloading local-settings.js..."
wget -nv https://phoenix.celenity.dev/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Creating /usr/lib/firefox/defaults/pref directory..."
sudo mkdir -v -p /usr/lib/firefox/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /usr/lib/firefox/defaults/pref to 755..."
sudo chmod -v 755 /usr/lib/firefox/defaults/pref || error_fn
echo


echo_green_text "Moving local-settings.js to /usr/lib/firefox/defaults/pref/local-settings.js..."
sudo mv -v local-settings.js /usr/lib/firefox/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Adding Prebuilt MPR repo if not already installed..."
curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr ${Release_CodeName}" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
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
