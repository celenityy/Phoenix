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


if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	echo
	exit 1
fi


echo_green_text "Downloading new mozilla.cfg"
wget -nv https://codeberg.org/celenity/Phoenix/raw/branch/main/mozilla.cfg || error_fn
echo


echo_green_text "Overwriting old mozilla.cfg with new mozilla.cfg"
sudo mv -v mozilla.cfg /usr/lib64/firefox/mozilla.cfg || error_fn
echo

echo_green_text "Uninstalling the old phoenix-policies package"
sudo dnf remove phoenix-policies || error_fn
echo

echo_green_text "Removing the old Phoenix-Policies COPR Repo"
sudo dnf copr remove retold3202/Phoenix-Policies || error_fn
echo

echo_green_text "Adding new Phoenix-Policies COPR Repo to DNF"
sudo dnf copr enable celenity/phoenix-policies || error_fn
echo

echo_green_text "Updating DNF cache"
sudo dnf update --refresh || error_fn
echo


echo_green_text "Installing phoenix-policies package"
sudo dnf install phoenix-policies || error_fn
echo


echo_gree_text "Thank you for taking the time to run our migration script. Enjoy :)"
