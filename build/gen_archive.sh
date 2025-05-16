#!/usr/bin/env bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

rm archives/phoenix.zip archives/phoenix-flatpak.zip archives/phoenix-osx.zip

echo_green_text "Creating archives/phoenix.zip..."

zip -r -FS archives/phoenix.zip * -x 'android/*' 'archives/*' 'assets/*' 'build/*' 'configs/macos/*' 'configs/phoenix.cfg' 'extensions/*' 'flake.*' 'installer_scripts/*' 'macos/*' 'prefs/phoenix-android.js' 'prefs/phoenix-extended*' 'uBlock/*' 'uninstaller_scripts/*' 'user.js' 'userjs/flatpak/*' 'userjs/macos/*' 'userjs/macos-intel/*' 'windows/*' '*.code-workspace' '.domains' '.DS_Store' '.git*' '_redirects'

echo_green_text "Creating archives/phoenix-flatpak.zip..."

zip -r -FS archives/phoenix-flatpak.zip * -x 'android/*' 'archives/*' 'assets/*' 'build/*' 'configs/macos/*' 'configs/phoenix.cfg' 'etc/*' 'extensions/*' 'flake.*' 'installer_scripts/*' 'macos/*' 'prefs/phoenix-android.js' 'prefs/phoenix-extended*' 'uBlock/*' 'uninstaller_scripts/*' 'user.js' 'userjs/linux/*' 'userjs/macos/*' 'userjs/macos-intel/*' 'windows/*' '*.code-workspace' '.domains' '.DS_Store' '.git*' '_redirects'

echo_green_text "Creating archives/phoenix-osx.zip..."

zip -r -FS archives/phoenix-osx.zip * -x 'android/*' 'archives/*' 'assets/*' 'build/*' 'configs/apple-maps.cfg' 'configs/discord.cfg' 'configs/element.cfg' 'configs/google-maps.cfg' 'configs/hardened.cfg' 'configs/phoenix.cfg' 'configs/twitter.cfg' 'configs/ui-fix.cfg' 'configs/ui-fix/*' 'configs/youtube.cfg' 'etc/*' 'extensions/*' 'flake.*' 'installer_scripts/*' 'macos/defaults/*' 'macos/intel/*' 'macos/Library/*' 'macos/phoenix-bootstrap.cfg' 'phoenix.cfg' 'policies.json' 'prefs/*' 'uBlock/*' 'uninstaller_scripts/*' 'user.js' 'userjs/flatpak/*' 'userjs/linux/*' 'windows/*' '*.code-workspace' '.domains' '.DS_Store' '.git*' '_redirects'
