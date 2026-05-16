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
PHOENIX_INSTALL_LAUNCHCTL='/bin/launchctl'

# open
PHOENIX_INSTALL_OPEN='/usr/bin/open'

# sleep
PHOENIX_INSTALL_SLEEP='/bin/sleep'

# sudo
PHOENIX_INSTALL_SUDO='/usr/bin/sudo'

# xattr
PHOENIX_INSTALL_XATTR='/usr/bin/xattr -v -r -d com.apple.quarantine'

# Save temporary files/downloads to /tmp
PHOENIX_INSTALL_TEMP='/tmp'

pushd "${PHOENIX_INSTALL_TEMP}"

echo_green_text "Welcome to the Phoenix installer for macOS!"
echo_red_text "Before proceeding: You MUST grant your Terminal the 'App Management' permission by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Quit & Re-open' WHEN PROMPTED, AND RE-RUN THIS SCRIPT..."
echo_red_text "This is ONLY required for initial installation, and you are strongly recommended to revoke the 'App Management' permission once you are done."
echo_green_text "If you are unable/unwilling to grant your Terminal this permission, you can follow the instructions here to copy the files manually: https://phoenix.celenity.dev#manual-installation."
"${PHOENIX_INSTALL_SLEEP}" 5 || error_fn
echo
"${PHOENIX_INSTALL_OPEN}" /System/Applications/'System Settings'.app || error_fn
echo
"${PHOENIX_INSTALL_SLEEP}" 5 || error_fn
echo
echo_red_text "Press enter to continue."
read

## Install Phoenix
echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://gitlab.com/celenityy/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update --force || error_fn
echo

echo_green_text "Ensuring Homebrew packages are up to date..."
brew upgrade --greedy || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist to 644..."
sudo chmod -v 644 dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
sudo cp dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
"${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist to 644..."
sudo chmod -v 644 dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
sudo cp dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist..."
"${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_DISABLE.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist to 644..."
sudo chmod -v 644 dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
sudo cp dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist..."
"${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_NO_REPORT.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist to 644..."
sudo chmod -v 644 dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
sudo cp dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist..."
"${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER_URL.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist to 644..."
sudo chmod -v 644 dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
sudo cp dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
"${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist to 644..."
sudo chmod -v 644 dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist..."
sudo cp dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist..."
"${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_MOZ_CRASH.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist to 644..."
sudo chmod -v 644 dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist..."
sudo cp dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist..."
"${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/shared/Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist" || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.SSLKEYLOGFILE.plist to 644..."
sudo chmod -v 644 dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.SSLKEYLOGFILE.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
sudo cp dev.celenity.phoenix.env.SSLKEYLOGFILE.plist /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
"${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Creating /Library/celenity/Phoenix directory..."
sudo mkdir -vp /Library/celenity/Phoenix || error_fn
echo

echo_green_text "Changing permissions of Library/celenity/Phoenix to 744..."
sudo chmod -v 744 /Library/celenity/Phoenix || error_fn
echo

echo -e ""
echo_green_text "Are you using an Apple Silicon (M-series chip) or Intel device?";
echo_green_text "Your options are:";
echo_red_text "1. Silicon";
echo_green_text "2. Intel";
read "DEVICETYPE?Please enter your selection: "
case ${DEVICETYPE} in
	"apple" | "Apple" | "APPLE" | "silicon" | "Silicon" | "SILICON" | 1)
		echo_green_text "Installing phoenix-osx package..."
		brew install phoenix-osx || error_fn
		echo

		echo_green_text "Downloading phoenix-apply.sh..."
		curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/Library/celenity/Phoenix/phoenix-apply.sh -o "${PHOENIX_INSTALL_TEMP}/phoenix-apply.sh" || error_fn
		echo

		echo_green_text "Changing permissions of phoenix-apply.sh to 744..."
		sudo chmod -v 744 phoenix-apply.sh || error_fn
		echo

		echo_green_text "Copying phoenix-apply.sh to /Library/celenity/Phoenix/phoenix-apply.sh..."
		sudo cp phoenix-apply.sh /Library/celenity/Phoenix/phoenix-apply.sh || error_fn
		echo

		echo_green_text "Downloading dev.celenity.phoenix.apply.plist..."
		curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/Library/LaunchDaemons/dev.celenity.phoenix.apply.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.apply.plist" || error_fn
		echo

		echo_green_text "Changing permissions of dev.celenity.phoenix.apply.plist to 644..."
		sudo chmod -v 644 dev.celenity.phoenix.apply.plist || error_fn
		echo

		echo_green_text "Copying dev.celenity.phoenix.apply.plist to /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist..."
		sudo cp dev.celenity.phoenix.apply.plist /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo

		echo_green_text "Loading dev.celenity.phoenix.apply.plist..."
		sudo "${PHOENIX_INSTALL_LAUNCHCTL}" load -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.plist || error_fn
		echo

        echo_green_text "Downloading dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist..."
        curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-silicon/Library/LaunchAgents/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist" || error_fn
        echo

        echo_green_text "Changing permissions of dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist to 644..."
        sudo chmod -v 644 dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist || error_fn
        echo

        echo_green_text "Copying dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist..."
        sudo cp dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist /Library/LaunchAgents/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist || error_fn
        echo

        echo_green_text "Loading dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist..."
        "${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist || error_fn
        echo

		echo -e ""
		echo_green_text "Where is your installation of Firefox located?";
		echo_green_text "Your options are:";
		echo_red_text "1. system - /Applications/Firefox.app";
		echo_green_text "2. user - ${HOME}/Applications/Firefox.app";
		read "LOCATION?Please enter your selection: "
		case ${LOCATION} in
			"system" | "System" | "SYSTEM" | 1)
				## Ensure Firefox isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				"${PHOENIX_INSTALL_SUDO}" "${PHOENIX_INSTALL_XATTR}" /Applications/Firefox.app

				echo_green_text "Creating /Applications/Firefox.app/Contents/Resources/defaults/pref directory..."
				sudo mkdir -vp /Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Changing permissions of /Applications/Firefox.app/Contents/Resources/defaults/pref to 755..."
				sudo chmod -v -R 755 /Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/phoenix-osx/defaults/pref/phoenix.js to /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js..."
				sudo ln -s /opt/homebrew/opt/phoenix-osx/defaults/pref/phoenix.js /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/phoenix-osx/macos/phoenix.cfg to /Applications/Firefox.app/Contents/Resources/phoenix.cfg.."
				sudo ln -s /opt/homebrew/opt/phoenix-osx/macos/phoenix.cfg /Applications/Firefox.app/Contents/Resources/phoenix.cfg || error_fn
				echo
				;;

			"user" | "User" | "USER" | 2)
				## Ensure Firefox isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				"${PHOENIX_INSTALL_XATTR}" "${HOME}/Applications/Firefox.app"

				echo_green_text "Creating ${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref directory..."
				mkdir -vp "${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref" || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/phoenix-osx/defaults/pref/phoenix.js to "${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js"..."
				ln -s /opt/homebrew/opt/phoenix-osx/defaults/pref/phoenix.js "${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js" || error_fn
				echo

				echo_green_text "Creating a symlink from /opt/homebrew/opt/phoenix-osx/macos/phoenix.cfg to "${HOME}/Applications/Firefox.app/Contents/Resources/phoenix.cfg".."
				ln -s /opt/homebrew/opt/phoenix-osx/macos/phoenix.cfg "${HOME}/Applications/Firefox.app/Contents/Resources/phoenix.cfg" || error_fn
				echo
				;;
		esac
		;;

	"intel" | "Intel" | "INTEL" | 2)
		echo_green_text "Installing phoenix-osx-intel package..."
		brew install phoenix-osx-intel || error_fn
		echo

		echo_green_text "Downloading phoenix-apply-intel.sh..."
		curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-intel/Library/celenity/Phoenix/phoenix-apply-intel.sh -o "${PHOENIX_INSTALL_TEMP}/phoenix-apply-intel.sh" || error_fn
		echo

		echo_green_text "Changing permissions of phoenix-apply-intel.sh to 744..."
		sudo chmod -v 744 phoenix-apply-intel.sh || error_fn
		echo

		echo_green_text "Copying phoenix-apply-intel.sh to /Library/celenity/Phoenix/phoenix-apply-intel.sh..."
		sudo cp phoenix-apply-intel.sh /Library/celenity/Phoenix/phoenix-apply-intel.sh || error_fn
		echo

		echo_green_text "Downloading dev.celenity.phoenix.apply.intel.plist..."
		curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-intel/Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.apply.intel.plist" || error_fn
		echo

		echo_green_text "Changing permissions of dev.celenity.phoenix.apply.intel.plist to 644..."
		sudo chmod -v 644 dev.celenity.phoenix.apply.intel.plist || error_fn
		echo

		echo_green_text "Copying dev.celenity.phoenix.apply.intel.plist to /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist..."
		sudo cp dev.celenity.phoenix.apply.intel.plist /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo

		echo_green_text "Loading dev.celenity.phoenix.apply.intel.plist..."
		sudo "${PHOENIX_INSTALL_LAUNCHCTL}" load -w /Library/LaunchDaemons/dev.celenity.phoenix.apply.intel.plist || error_fn
		echo

        echo_green_text "Downloading dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist..."
        curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/osx-intel/Library/LaunchAgents/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist" || error_fn
        echo

        echo_green_text "Changing permissions of dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist to 644..."
        sudo chmod -v 644 dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist || error_fn
        echo

        echo_green_text "Copying dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist..."
        sudo cp dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist /Library/LaunchAgents/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist || error_fn
        echo

        echo_green_text "Loading dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist..."
        "${PHOENIX_INSTALL_LAUNCHCTL}" load /Library/LaunchAgents/dev.celenity.phoenix.env.PHOENIX_HOST_PLATFORM.plist || error_fn
        echo

		echo -e ""
		echo_green_text "Where is your installation of Firefox located?";
		echo_green_text "Your options are:";
		echo_red_text "1. system - /Applications/Firefox.app";
		echo_green_text "2. user - ${HOME}/Applications/Firefox.app";
		read "LOCATION?Please enter your selection: "
		case ${LOCATION} in
			"system" | "System" | "SYSTEM" | 1)
				## Ensure Firefox isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				"${PHOENIX_INSTALL_SUDO}" "${PHOENIX_INSTALL_XATTR}" /Applications/Firefox.app

				echo_green_text "Creating /Applications/Firefox.app/Contents/Resources/defaults/pref directory..."
				sudo mkdir -vp /Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Changing permissions of /Applications/Firefox.app/Contents/Resources/defaults/pref to 755..."
				sudo chmod -v -R 755 /Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/phoenix-osx-intel/defaults/pref/phoenix.js to /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js..."
				sudo ln -s /usr/local/opt/phoenix-osx-intel/defaults/pref/phoenix.js /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/phoenix-osx-intel/phoenix.cfg to /Applications/Firefox.app/Contents/Resources/phoenix.cfg.."
				sudo ln -s /usr/local/opt/phoenix-osx-intel/phoenix.cfg /Applications/Firefox.app/Contents/Resources/phoenix.cfg || error_fn
				echo
				;;

			"user" | "User" | "USER" | 2)
				## Ensure Firefox isn't quarantined so we don't break it...
				# https://support.mozilla.org/kb/deploying-firefox-customizations-macos
				"${PHOENIX_INSTALL_XATTR}" "${HOME}/Applications/Firefox.app"

				echo_green_text "Creating ${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref directory..."
				mkdir -vp "${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref" || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/phoenix-osx-intel/defaults/pref/phoenix.js to "${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js"..."
				ln -s /usr/local/opt/phoenix-osx-intel/defaults/pref/phoenix.js "${HOME}/Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js" || error_fn
				echo

				echo_green_text "Creating a symlink from /usr/local/opt/phoenix-osx-intel/phoenix.cfg to "${HOME}/Applications/Firefox.app/Contents/Resources/phoenix.cfg".."
				ln -s /usr/local/opt/phoenix-osx-intel/phoenix.cfg "${HOME}/Applications/Firefox.app/Contents/Resources/phoenix.cfg" || error_fn
				echo
				;;
		esac
		;;
esac

popd

echo_red_text "You must now revoke the 'App Management' permission from your Terminal by navigating to 'System Settings' -> 'Privacy & Security' -> 'App Management'"
echo_green_text "PLEASE SELECT 'Later' WHEN IT ASKS YOU TO QUIT AND RE-OPEN YOUR TERMINAL..."
"${PHOENIX_INSTALL_SLEEP}" 5 || error_fn
echo
"${PHOENIX_INSTALL_OPEN}" /System/Applications/'System Settings'.app || error_fn
echo
"${PHOENIX_INSTALL_SLEEP}" 5 || error_fn
echo
echo_green_text "Press enter to continue once you are finished."
read

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at our 'Extended' config for more comprehensive protection, at the cost of ocassional breakage.\nYou can learn more here: https://phoenix.celenity.dev/#extended.\n"

echo_red_text "Your system will now reboot to finalize your installation."
"${PHOENIX_INSTALL_SLEEP}" 5 || error_fn
echo
echo_green_text "Press enter to continue."
read

"${PHOENIX_INSTALL_SUDO}" /sbin/reboot
