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
echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
/bin/launchctl unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
sudo /bin/rm -f /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

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

echo_green_text "Unloading dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
/bin/launchctl unload /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
sudo /bin/rm -f /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Unloading dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
/bin/launchctl unload /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Removing dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
sudo /bin/rm -f /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Removing the /Library/celenity/Phoenix directory..."
sudo /bin/rm -rf /Library/celenity/Phoenix || error_fn
echo

echo_green_text "Removing org.mozilla.firefox.plist..."
sudo /bin/rm -f /Library/Preferences/org.mozilla.firefox.plist || error_fn
echo
sudo /bin/rm -f "${HOME}/Library/Preferences/org.mozilla.firefox.plist" || error_fn
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
		sudo /bin/launchctl unload -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo

		echo_green_text "Removing dev.celenity.phoenix.apply.plist..."
		sudo /bin/rm -f /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo
		;;

	"intel" | "Intel" | "INTEL" | 2)
        echo_green_text "Uninstalling phoenix-osx-intel..."
        brew uninstall phoenix-osx-intel || error_fn
        echo

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
echo_green_text "2. user - ${HOME}/Applications/Firefox.app";
read "LOCATION?Please enter your selection: "
case ${LOCATION} in
	"system" | "System" | "SYSTEM" | 1)
        echo_green_text "Removing phoenix.js..."
		sudo /bin/rm -f /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js || error_fn
		echo

		echo_green_text "Removing phoenix.cfg..."
		sudo /bin/rm -f /Applications/Firefox.app/Contents/Resources/phoenix.cfg || error_fn
		echo
		;;

	"user" | "User" | "USER" | 2)
		echo_green_text "Removing phoenix.js..."
		/bin/rm -f "${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js" || error_fn
		echo

		echo_green_text "Removing phoenix.cfg..."
		/bin/rm -f "${HOME}/Applications/Firefox.app/Contents/Resources/phoenix.cfg" || error_fn
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
			brew update && brew upgrade --force --verbose || error_fn
			echo
			;;
		
		"n" | "no" | "N" | "NO")
			;;
esac

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

sudo /sbin/reboot
