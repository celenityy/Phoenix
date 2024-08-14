#! /usr/bin/env bash

sudo mkdir -p ~/phoenix_temp

cd ~/phoenix_temp

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/mozilla.cfg

sudo mv mozilla.cfg /Applications/Firefox.app/Contents/Resources/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/defaults/pref/local-settings.js

sudo mkdir -p /Applications/Firefox.app/Contents/Resources/defaults/pref

sudo chmod 755 /Applications/Firefox.app/Contents/Resources/defaults/pref

sudo mv local-settings.js /Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js

sudo rm -rf ~/phoenix_temp

echo "Make sure to install your policies & enjoy :D"