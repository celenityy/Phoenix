#!/bin/zsh

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/mozilla.cfg

sudo mv mozilla.cfg /Applications/Firefox.app/Contents/Resources/mozilla.cfg

wget https://codeberg.org/Magnesium1062/Phoenix/raw/branch/main/defaults/pref/local-settings.js

sudo mkdir -p /Applications/Firefox.app/Contents/Resources/defaults/pref

sudo chmod 755 /Applications/Firefox.app/Contents/Resources/defaults/pref

sudo mv local-settings.js /Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js

brew tap Magnesium1062/Phoenix-Policies-macOS https://codeberg.org/Magnesium1062/Phoenix-Policies-macOS

brew update

brew install phoenix-policies

cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Application/Firefox.app/Contents/Resources/distribution/policies.json

echo 'alias phoenix-up="cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Application/Firefox.app/Contents/Resources/distribution/policies.json"' >> ~/.zshrc

printf "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can grab them from here https://codeberg.org/Magnesium1062/Phoenix/src/branch/main/configs. Just drag the user.js under the config of your choice to your profile directory, and enjoy.\n"

printf "IMPORTANT: Make sure to run the command "phoenix-up" after you update your policies.\nYou can set an alias in your ~/.zshrc to make this easier, such as:\nalias update='brew update && brew upgrade --force && phoenix-up'"