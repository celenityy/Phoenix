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

echo_green_text "Creating /Applications/Firefox.app/Contents/Resources/defaults/pref directory..."
sudo /bin/mkdir -v -p /Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /Applications/Firefox.app/Contents/Resources/defaults/pref to 644..."
sudo /bin/chmod -v 644 /Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
echo

echo_green_text "Copying phoenix-bootstrap.js to /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix-bootstrap.js..."
sudo /bin/cp phoenix-bootstrap.js /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix-bootstrap.js || error_fn
echo

echo_green_text "Copying phoenix-bootstrap.cfg to /Applications/Firefox.app/Contents/Resources/phoenix-bootstrap.cfg.."
sudo /bin/cp phoenix-bootstrap.cfg /Applications/Firefox.app/Contents/Resources/phoenix-bootstrap.js || error_fn
echo

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#extended.\n"
