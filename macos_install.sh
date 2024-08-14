#!/bin/bash

mkdir ~/phoenix_temp

cd ~/phoenix_temp

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/mozilla.cfg

mv mozilla.cfg /Applications/Firefox.app/Contents/Resources/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/defaults/pref/local-settings.js

mkdir /Applications/Firefox.app/Contents/Resources/defaults/pref

mv local-settings.js /Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js

echo "Make sure to install your policies & enjoy :D"