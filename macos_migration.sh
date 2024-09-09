#!/bin/zsh

wget https://phoenix.celenity.dev/mozilla.cfg

sudo mv mozilla.cfg /Applications/Firefox.app/Contents/Resources/mozilla.cfg

brew uninstall phoenix-policies

brew untap Magnesium1062/Phoenix-Policies-macOS

brew tap celenity/Phoenix-Policies-macOS https://codeberg.org/celenity/Phoenix-Policies-macOS

brew update

brew upgrade --force

brew install phoenix-policies

cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json

printf "Thank you for taking the time to run our migration script. Enjoy :)"