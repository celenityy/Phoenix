#!/bin/zsh

## Functions
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

## Download and run the uninstall script
uninstall_phoenix() {
	curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL $1
	echo
	echo
	/bin/zsh $2
}

## Scripts are here
URL="https://gitlab.com/celenityy/Phoenix/-/raw/pages/uninstaller_scripts/macos"

## Scripts file
SCRIPT=("phoenix-uninstall-system.sh"
		"phoenix-uninstall-user.sh")

echo_green_text "Welcome to the Phoenix Uninstaller for macOS!"
echo_red_text "Sorry to see you go :("
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_red_text "You are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can remove the files manually as laid out here: https://phoenix.celenity.dev#manual-installation."
/bin/sleep 5
/usr/bin/open /System/Applications/'System Settings'.app
/bin/sleep 5
echo_red_text "Press enter to continue."
read

## Uninstall Phoenix
echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
/bin/launchctl unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
sudo /bin/rm -f /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
/bin/launchctl unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
sudo /bin/rm -f /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
/bin/launchctl unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
sudo /bin/rm -f /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Removing the /Library/celenity/Phoenix directory..."
sudo /bin/rm -rf /Library/celenity/Phoenix || error_fn
echo

echo_green_text "Removing org.mozilla.firefox.plist..."
sudo /bin/rm -f /Library/Preferences/org.mozilla.firefox.plist || error_fn
echo
sudo /bin/rm -f ~/Library/Preferences/org.mozilla.firefox.plist || error_fn
echo

echo_green_text "Uninstalling phoenix-osx..."
brew uninstall phoenix-osx || error_fn
echo

read "RESULT?Would you also like to remove celenity's Homebrew Tap? [Y/n] "
echo

case ${RESULT} in

		"y" | "yes" | "YES" | "Y")
			echo_green_text "Removing celenity's Tap..."
			brew untap celenity/tap || error_fn
			echo

			echo_green_text "Updating Homebrew cache..."
			brew update && brew upgrade --force --verbose || error_fn
			echo
			;;
		
		"n" | "no" | "N" | "NO")
			;;
esac

echo -e ""
echo_green_text "Are you using an Apple Silicon (M-series chip) or Intel device?";
echo_green_text "Your options are:";
echo_red_text "1. Silicon";
echo_green_text "2. Intel";
read "LOCATION?Please enter your selection: "
case ${LOCATION} in
	"apple" | "Apple" | "APPLE" | "silicon" | "Silicon" | "SILICON" | 1)
        echo_green_text "Unloading dev.celenity.phoenix.apply.plist..."
		sudo /bin/launchctl unload -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo

		echo_green_text "Removing dev.celenity.phoenix.apply.plist..."
		sudo /bin/rm -f /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo
		;;

	"intel" | "Intel" | "INTEL" | 2)
		echo_green_text "Unloading dev.celenity.phoenix.apply.intel.plist..."
		sudo /bin/launchctl unload -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo

		echo_green_text "Removing dev.celenity.phoenix.apply.intel.plist..."
		sudo /bin/rm -f /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo
		;;
esac

echo -e ""
echo_green_text "Where is your installation of Firefox located?";
echo_green_text "Your options are:";
echo_red_text "1. system - /Applications/Firefox.app";
echo_green_text "2. user - ~/Applications/Firefox.app";
read "LOCATION?Please enter your selection: "
case ${LOCATION} in
	"system" | "System" | "SYSTEM" | 1)
        TARGET_SCRIPT="${SCRIPT[0]}"
		;;

	"user" | "User" | "USER" | 2)
		TARGET_SCRIPT="${SCRIPT[1]}"
		;;
esac

## Download and run choosen uninstall script
uninstall_phoenix "${URL}"/"${TARGET_SCRIPT}" "${TARGET_SCRIPT}"
