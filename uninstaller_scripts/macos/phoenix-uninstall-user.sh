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

echo_green_text "Removing phoenix-bootstrap.js..."
/bin/rm -f ~/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix-bootstrap.js || error_fn
echo

echo_green_text "Removing phoenix-bootstrap.cfg..."
/bin/rm -f ~/Applications/Firefox.app/Contents/Resources/phoenix-bootstrap.cfg || error_fn
echo

echo_red_text "You must now revoke the 'App Management' permission from your Terminal by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Later' WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
/bin/sleep 5
/usr/bin/open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(."
echo_green_text "Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"

echo_red_text "Your system will now reboot to finalize your uninstallation."
/bin/sleep 5
echo_green_text "Press enter to continue."
read

sudo reboot
