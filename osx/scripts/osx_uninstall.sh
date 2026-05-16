#!/bin/zsh

set -euo pipefail

# Functions
echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo_red_text "Something went wrong! The script failed."
	echo_red_text "Please report this (with the output message) to https://phoenix.celenity.dev/issues"
	echo
	exit 1
}

# launchctl
PHOENIX_UNINSTALL_LAUNCHCTL='/bin/launchctl'

# open
PHOENIX_UNINSTALL_OPEN='/usr/bin/open'

# rm
PHOENIX_UNINSTALL_RM='/bin/rm -f'

# sleep
PHOENIX_UNINSTALL_SLEEP='/bin/sleep'

# sudo
PHOENIX_UNINSTALL_SUDO='/usr/bin/sudo'

# Save temporary files/downloads to /tmp
PHOENIX_UNINSTALL_TEMP='/tmp'

pushd "${PHOENIX_UNINSTALL_TEMP}"

echo_green_text "Welcome to the Phoenix Uninstaller for macOS!"
echo_red_text "Sorry to see you go :("
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_red_text "You are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can remove the files manually as laid out here: https://phoenix.celenity.dev#manual-installation."
"${PHOENIX_UNINSTALL_SLEEP}" 5 || error_fn
echo
"${PHOENIX_UNINSTALL_OPEN}" /System/Applications/'System Settings'.app
"${PHOENIX_UNINSTALL_SLEEP}" 5 || error_fn
echo
echo_red_text "Press enter to continue."
read

## Uninstall Phoenix
echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
"${PHOENIX_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${PHOENIX_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${PHOENIX_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
"${PHOENIX_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
"${PHOENIX_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
"${PHOENIX_UNINSTALL_LAUNCHCTL}" unload /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Removing the /Library/celenity/Phoenix directory..."
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" -r /Library/celenity/Phoenix || error_fn
echo

echo_green_text "Removing org.mozilla.firefox.plist..."
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/Preferences/org.mozilla.firefox.plist || error_fn
echo
"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" "${HOME}/Library/Preferences/org.mozilla.firefox.plist" || error_fn
echo

echo -e ""
echo_green_text "Are you using an Apple Silicon (M-series chip) or Intel device?";
echo_green_text "Your options are:";
echo_red_text "1. Silicon";
echo_green_text "2. Intel";
read "DEVICETYPE?Please enter your selection: "
case ${DEVICETYPE} in
	"apple" | "Apple" | "APPLE" | "silicon" | "Silicon" | "SILICON" | 1)
        echo_green_text "Uninstalling phoenix-osx..."
        brew uninstall phoenix-osx || error_fn
        echo

		echo_green_text "Unloading dev.celenity.phoenix.apply.plist..."
		"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_LAUNCHCTL}" unload -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo

		echo_green_text "Removing dev.celenity.phoenix.apply.plist..."
		"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo
		;;

	"intel" | "Intel" | "INTEL" | 2)
        echo_green_text "Uninstalling phoenix-osx-intel..."
        brew uninstall phoenix-osx-intel || error_fn
        echo

		echo_green_text "Unloading dev.celenity.phoenix.apply.intel.plist..."
		"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_LAUNCHCTL}" unload -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo

		echo_green_text "Removing dev.celenity.phoenix.apply.intel.plist..."
		"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo
		;;
esac

echo -e ""
echo_green_text "Where is your installation of Firefox located?";
echo_green_text "Your options are:";
echo_red_text "1. system - /Applications/Firefox.app";
echo_green_text "2. user - ${HOME}/Applications/Firefox.app";
read "LOCATION?Please enter your selection: "
case ${LOCATION} in
	"system" | "System" | "SYSTEM" | 1)
        echo_green_text "Removing phoenix.js..."
		"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js || error_fn
		echo

		echo_green_text "Removing phoenix.cfg..."
		"${PHOENIX_UNINSTALL_SUDO}" "${PHOENIX_UNINSTALL_RM}" /Applications/Firefox.app/Contents/Resources/phoenix.cfg || error_fn
		echo
		;;

	"user" | "User" | "USER" | 2)
		echo_green_text "Removing phoenix.js..."
		"${PHOENIX_UNINSTALL_RM}" "${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js" || error_fn
		echo

		echo_green_text "Removing phoenix.cfg..."
		"${PHOENIX_UNINSTALL_RM}" "${HOME}/Applications/Firefox.app/Contents/Resources/phoenix.cfg" || error_fn
		echo
		;;
esac

read "RESULT?Would you also like to remove celenity's Homebrew Tap? [Y/n] "
echo
case ${RESULT} in

		"y" | "yes" | "YES" | "Y")
			echo_green_text "Removing celenity's Tap..."
			brew untap celenity/tap || error_fn
			echo

			echo_green_text "Updating Homebrew cache..."
			brew update --force && brew upgrade --greedy || error_fn
			echo
			;;

		"n" | "no" | "N" | "NO")
			;;
esac

popd

echo_red_text "You must now revoke the 'App Management' permission from your Terminal by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Later' WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
"${PHOENIX_UNINSTALL_SLEEP}" 5 || error_fn
echo
"${PHOENIX_UNINSTALL_OPEN}" /System/Applications/'System Settings'.app
"${PHOENIX_UNINSTALL_SLEEP}" 5 || error_fn
echo
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "Thanks for giving Phoenix a shot. Sorry to see you go :(."
echo_green_text "Please leave feedback on how we can improve! https://phoenix.celenity.dev/issues"

echo_red_text "Your system will now reboot to finalize your uninstallation."
"${PHOENIX_UNINSTALL_SLEEP}" 5 || error_fn
echo
echo_green_text "Press enter to continue."
read

"${PHOENIX_UNINSTALL_SUDO}" /sbin/reboot
