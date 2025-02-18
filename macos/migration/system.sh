
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

echo_green_text "Welcome to the Phoenix (System) migration script for macOS!"
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_red_text "This is ONLY required for the initial migration/installation of Phoenix, and you are strongly recommended to revoke the 'App Management' permission once you are done."
/bin/sleep 5
open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_red_text "Press enter to continue."
read

## Prepare Phoenix
echo_green_text "Removing the legacy 'phoenix.cfg'..."
sudo /bin/rm -f /Applications/Firefox.app/Contents/Resources/phoenix.cfg || error_fn
echo

echo_green_text "Removing the legacy 'phoenix-desktop.js'..."
sudo /bin/rm -f /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix-desktop.js || error_fn
echo

echo_green_text "Removing the legacy 'policies.json'..."
sudo /bin/rm -f /Applications/Firefox.app/Contents/Resources/distribution/policies.json || error_fn
echo

echo_green_text "Success! You're now ready to run the new Phoenix installation script for macOS. :D"
