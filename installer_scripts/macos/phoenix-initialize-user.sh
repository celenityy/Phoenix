#!/bin/zsh

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

## Downloaded files save in /tmp
cd /tmp

## Ensure Firefox isn't quarantined so we don't break it...
# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
/usr/bin/xattr -v -r -d com.apple.quarantine ~/Applications/Firefox.app

echo_green_text "Changing permissions of phoenix-bootstrap.js to 644..."
/bin/chmod -v 644 phoenix-bootstrap.js || error_fn
echo

echo_green_text "Changing permissions of phoenix-bootstrap.cfg to 644..."
/bin/chmod -v 644 phoenix-bootstrap.cfg || error_fn
echo

echo_green_text "Creating ~/Applications/Firefox.app/Contents/Resources/defaults/pref directory..."
/bin/mkdir -v -p ~/Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
echo

echo_green_text "Copying phoenix-bootstrap.js to ~/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix-bootstrap.js..."
/bin/cp phoenix-bootstrap.js ~/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix-bootstrap.js || error_fn
echo

echo_green_text "Copying phoenix-bootstrap.cfg to ~/Applications/Firefox.app/Contents/Resources/phoenix-bootstrap.cfg.."
/bin/cp phoenix-bootstrap.cfg ~/Applications/Firefox.app/Contents/Resources/phoenix-bootstrap.cfg || error_fn
echo

echo_red_text "You must now revoke the 'App Management' permission from your Terminal by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Later' WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
/bin/sleep 5
/usr/bin/open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at our 'Extended' config for more comprehensive protection, at the cost of ocassional breakage.\nYou can learn more here: https://phoenix.celenity.dev/#extended.\n"

echo_red_text "Your system will now reboot to finalize your installation."
/bin/sleep 5
echo_green_text "Press enter to continue."
read

sudo reboot
