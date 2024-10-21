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
	exit 1
}

if [ $(id --user) -ne 0 ]; then
	echo_red_text "You must run this script with sudo"
	exit 1
fi

### Start of checking version ###

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

### End of checking version ###


echo_green_text "Downloading mozilla.cfg"
wget -nv https://phoenix.celenity.dev/mozilla.cfg || error_fn
echo


echo_green_text "Moving mozilla.cfg to /usr/lib64/firefox/mozilla.cfg"
sudo mv -v mozilla.cfg /usr/lib64/firefox/mozilla.cfg || error_fn
echo


echo_green_text "Downloading local-settings.js"
wget -nv https://phoenix.celenity.dev/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Creating /usr/lib64/firefox/defaults/pref directory"
sudo mkdir -v -p /usr/lib64/firefox/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /usr/lib64/firefox/defaults/pref to 755"
sudo chmod -v 755 /usr/lib64/firefox/defaults/pref || error_fn
echo


echo_green_text "Moving local-settings.js to /usr/lib64/firefox/defaults/pref/local-settings.js"
sudo mv -v local-settings.js /usr/lib64/firefox/defaults/pref/local-settings.js || error_fn
echo


echo_green_text "Adding Phoenix-Policies COPR Repo to DNF"
sudo dnf copr enable celenity/phoenix-policies || error_fn
echo

echo_green_text "Updating DNF cache"
sudo dnf update --refresh || error_fn
echo


echo_green_text "Installing phoenix-policies package"
sudo dnf install phoenix-policies || error_fn
echo


echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#complete-coverage.\n"
