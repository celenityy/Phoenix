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

echo_green_text "Welcome!"
echo_red_text "This script will set up environment variables on your system to disable Mozilla's Crash Reporter (for use with Phoenix)."

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/dev/macos/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
sudo /bin/cp dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/dev/macos/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
sudo /bin/cp dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/dev/macos/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
sudo /bin/cp dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "All done. :)"

echo_red_text "Your system will now reboot to apply your new environment variables."
/bin/sleep 5
echo_green_text "Press enter to continue."
read

sudo reboot
