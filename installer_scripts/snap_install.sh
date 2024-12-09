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
	echo -e "\033[31mPlease report this (with the output message) to https://phoenix.celenity.dev/issues\033[0m"
	echo
	exit 1
}


if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	echo
	exit 1
fi


echo_green_text "Downloading phoenix.cfg..."
wget -nv https://phoenix.celenity.dev/phoenix.cfg || error_fn
echo


echo_green_text "Moving phoenix.cfg to /snap/firefox/current/usr/lib/firefox/phoenix.cfg..."
sudo mv -v phoenix.cfg /snap/firefox/current/usr/lib/firefox/phoenix.cfg || error_fn
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


echo_green_text "Installing the lsb-release dependency if not already installed..."
sudo apt install lsb-release || error_fn
echo

echo_green_text "Adding Prebuilt MPR repo if not already installed..."
curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
echo

echo_green_text "Updating APT cache..."
sudo apt update || error_fn
echo


echo_green_text "Installing phoenix-policies package..."
sudo apt install phoenix-policies || error_fn
echo


echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#complete-coverage.\n"
