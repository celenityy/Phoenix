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


## Check SUDO permisson
if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	exit 1
fi


##Check version
Local_Fedora_Version=$(grep 'VERSION_ID=' /etc/os-release | cut -d'=' -f2)
Supported_Versions=(39 40 41)

check_version() {
	for i in ${Supported_Versions[@]}
	do
		if [[ ${i} -eq ${Local_Fedora_Version} ]]; then
			export result=0
			break
		else
			export result=1
		fi
	done
}
check_version

if [[ ${result} -eq 1 ]]; then
	echo_red_text "Sorry! Your Fedora version is not supported!"
	exit 1
fi


## Install Phoenix
echo_green_text "Downloading phoenix.cfg..."
wget -nv https://phoenix.celenity.dev/phoenix.cfg || error_fn
echo

echo_green_text "Moving phoenix.cfg to /usr/lib64/firefox/phoenix.cfg..."
sudo mv -v phoenix.cfg /usr/lib64/firefox/phoenix.cfg || error_fn
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

echo_green_text "Adding Phoenix-Policies COPR Repo to DNF..."
sudo dnf copr enable celenity/phoenix-policies || error_fn
echo

echo_green_text "Updating DNF cache..."
sudo dnf update --refresh || error_fn
echo

echo_green_text "Installing phoenix-policies package..."
sudo dnf install phoenix-policies || error_fn
echo

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#complete-coverage.\n"
