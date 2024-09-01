#! /usr/bin/env bash


cd /tmp


error_fn() {
		echo "\033[31mSomthing wrong! The script failed.\033[0m"
		exit 1;
}


if [ $(id --user) -ne 0 ]; then
		echo -e "\033[31mYou must run this script with sudo\033[0m"
fi


echo -e "\033[32mDownloading mozilla.cfg\033[0m"
wget -nv https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/mozilla.cfg || error_fn
echo


echo -e "\033[32mMoving mozzila.cfg to /usr/lib64/firefox/mozilla.cfg\033[0m"
sudo mv -v mozilla.cfg /usr/lib64/firefox/mozilla.cfg || error_fn
echo


echo -e "\033[32mDownloading local-settings.js\033[0m"
wget -nv https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/defaults/pref/local-settings.js || error_fn
echo


echo -e "\033[32mMaking /usr/lib64/firefox/defaults/pref dirctory\033[0m"
sudo mkdir -v -p /usr/lib64/firefox/defaults/pref || error_fn
echo

echo -e "\033[32mChanging permisions of /usr/lib64/firefox/defaults/pref to 755\033[0m"
sudo chmod -v 755 /usr/lib64/firefox/defaults/pref || error_fn
echo


echo -e "\033[32mMoving local-settings.js to /usr/lib64/firefox/defaults/pref/local-settings.js\033[0m"
sudo mv -v local-settings.js /usr/lib64/firefox/defaults/pref/local-settings.js || error_fn
echo


echo -e "\033[32mAdding Phoenix-Policies copr repository to DNF\033[0m"
sudo dnf copr enable retold3202/Phoenix-Policies || error_fn
echo

echo -e "\033[32mUpdating DNF cache\033[0m"
sudo dnf update --refresh || error_fn
echo


echo -e "\033[32mInstalling phoenix_policies package\033[0m"
sudo dnf install phoenix-policies || error_fn
echo


echo -e "\033[32mAll done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can grab them from here https://codeberg.org/Magnesium1062/Phoenix/src/branch/main/configs. Just drag the user.js under the config of your choice to your profile directory, and enjoy.\033[0m\n"
