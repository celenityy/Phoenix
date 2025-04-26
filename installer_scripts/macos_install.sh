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

## Download and run initialization script
initialize_phoenix() {
	wget -nv $1
	echo
	echo
	bash $2
}

## Scripts are here
URL="https://gitlab.com/celenityy/Phoenix/-/raw/pages/installer_scripts/macos"

## Scripts file
SCRIPT=("phoenix-initialize-system.sh"
		"phoenix-initialize-user.sh")

echo_green_text "Welcome to the Phoenix installer for macOS!"
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Quit & Re-open' WHEN PROMPTED, AND RE-RUN THIS SCRIPT..."
echo_red_text "This is ONLY required for initial installation, and you are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can follow the instructions here to copy the files manually: https://phoenix.celenity.dev#manual-installation."
/bin/sleep 5
open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_red_text "Press enter to continue."
read

## Install Phoenix
echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://gitlab.com/celenityy/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update || error_fn
echo

echo_green_text "Installing phoenix-osx package..."
brew install phoenix-osx || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
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
wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
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
wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
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

echo_green_text "Downloading phoenix-bootstrap.js..."
wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/defaults/pref/phoenix-bootstrap.js || error_fn
echo

echo_green_text "Downloading phoenix-bootstrap.cfg..."
wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/phoenix-bootstrap.cfg || error_fn
echo

echo_green_text "Creating /Library/celenity/Phoenix directory..."
sudo /bin/mkdir -v -p /Library/celenity/Phoenix || error_fn
echo

echo_green_text "Changing permissions of Library/celenity/Phoenix to 744..."
sudo /bin/chmod -v 744 /Library/celenity/Phoenix || error_fn
echo

echo -e ""
echo_green_text "Are you using an Apple Silicon (M-series chip) or Intel device?";
echo_green_text "Your options are:";
echo_red_text "1. Silicon";
echo_green_text "2. Intel";
read -p 'Please enter your selection: ' LOCATION
case ${LOCATION} in
	"apple" | "Apple" | "APPLE" | "silicon" | "Silicon" | "SILICON" | 1)
        echo_green_text "Downloading phoenix-apply.sh..."
		wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/celenity/Phoenix/phoenix-apply.sh || error_fn
		echo

		echo_green_text "Changing permissions of phoenix-apply.sh to 744..."
		sudo /bin/chmod -v 744 phoenix-apply.sh || error_fn
		echo

		echo_green_text "Copying phoenix-apply.sh to /Library/celenity/Phoenix/phoenix-apply.sh..."
		sudo /bin/cp phoenix-apply.sh /Library/celenity/Phoenix/phoenix-apply.sh || error_fn
		echo
		
		echo_green_text "Downloading dev.celenity.phoenix.apply.plist..."
		wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo

		echo_green_text "Changing permissions of dev.celenity.phoenix.apply.plist to 644..."
		sudo /bin/chmod -v 644 dev.celenity.phoenix.apply.plist || error_fn
		echo

		echo_green_text "Copying dev.celenity.phoenix.apply.plist to /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist..."
		sudo /bin/cp dev.celenity.phoenix.apply.plist /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo

		echo_green_text "Loading dev.celenity.phoenix.apply.plist..."
		sudo /bin/launchctl load -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo
		;;

	"intel" | "Intel" | "INTEL" | 2)
		echo_green_text "Downloading phoenix-apply-intel.sh..."
		wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/celenity/Phoenix/phoenix-apply-intel.sh || error_fn
		echo

		echo_green_text "Changing permissions of phoenix-apply-intel.sh to 744..."
		sudo /bin/chmod -v 744 phoenix-apply-intel.sh || error_fn
		echo

		echo_green_text "Copying phoenix-apply-intel.sh to /Library/celenity/Phoenix/phoenix-apply-intel.sh..."
		sudo /bin/cp phoenix-apply.sh /Library/celenity/Phoenix/phoenix-apply-intel.sh || error_fn
		echo

		echo_green_text "Downloading dev.celenity.phoenix.apply.intel.plist..."
		wget -nv https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo

		echo_green_text "Changing permissions of dev.celenity.phoenix.apply.intel.plist to 644..."
		sudo /bin/chmod -v 644 dev.celenity.phoenix.apply.intel.plist || error_fn
		echo

		echo_green_text "Copying dev.celenity.phoenix.apply.intel.plist to /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist..."
		sudo /bin/cp dev.celenity.phoenix.apply.intel.plist /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo

		echo_green_text "Loading dev.celenity.phoenix.apply.intel.plist..."
		sudo /bin/launchctl load -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo
		;;
esac

echo -e ""
echo_green_text "Where is your installation of Firefox located?";
echo_green_text "Your options are:";
echo_red_text "1. system - /Applications/Firefox.app";
echo_green_text "2. user - ~/Applications/Firefox.app";
read -p 'Please enter your selection: ' LOCATION
case ${LOCATION} in
	"system" | "System" | "SYSTEM" | 1)
        TARGET_SCRIPT="${SCRIPT[0]}"
		;;

	"user" | "User" | "USER" | 2)
		TARGET_SCRIPT="${SCRIPT[1]}"
		;;
esac

## Download and run choosen initializion script
initialize_phoenix "${URL}"/"${TARGET_SCRIPT}" "${TARGET_SCRIPT}"
