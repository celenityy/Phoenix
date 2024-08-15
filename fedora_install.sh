#! /usr/bin/env bash

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/mozilla.cfg

sudo mv mozilla.cfg /usr/lib64/firefox/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/defaults/pref/local-settings.js

sudo mkdir -p /usr/lib64/firefox/defaults/pref

sudo chmod 755 /usr/lib64/firefox/defaults/pref

sudo mv local-settings.js /usr/lib64/firefox/defaults/pref/local-settings.js

sudo dnf copr enable retold3202/Phoenix-Policies && sudo dnf update --refresh && sudo dnf install phoenix-policies

printf "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can grab them from here https://codeberg.org/Magnesium1062/Phoenix/src/branch/main/configs. Just drag the user.js under the config of your choice to your profile directory, and enjoy.\n"
