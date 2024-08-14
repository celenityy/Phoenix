#! /usr/bin/env bash

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/mozilla.cfg

sudo mv mozilla.cfg /usr/lib64/firefox/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/defaults/pref/local-settings.js

sudo mkdir -p /usr/lib64/firefox/defaults/pref

sudo chmod 755 /usr/lib64/firefox/defaults/pref

sudo mv local-settings.js /usr/lib64/firefox/defaults/pref/local-settings.js

echo "Make sure to install your policies & enjoy :D"