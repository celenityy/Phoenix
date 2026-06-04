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

# cp
PHOENIX_INSTALL_CP='/bin/cp'

# launchctl
PHOENIX_INSTALL_LAUNCHCTL='/bin/launchctl'

# mkdir
PHOENIX_INSTALL_MKDIR='/bin/mkdir -vp'

# sleep
PHOENIX_INSTALL_SLEEP='/bin/sleep'

# sudo
PHOENIX_INSTALL_SUDO='/usr/bin/sudo'

# Save temporary files/downloads to /tmp
PHOENIX_INSTALL_TEMP='/tmp'

pushd "${PHOENIX_INSTALL_TEMP}"

echo_green_text "Welcome to the Phoenix environment variable updater for macOS!"

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist" || error_fn
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

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist..."
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.MOZ_GFX_CRASH_TELEMETRY.plist" || error_fn
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
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --tlsv1.2 --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/shared/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist -o "${PHOENIX_INSTALL_TEMP}/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist" || error_fn
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

popd

echo_green_text "All done. :) Congratulations, you've successfully updated Phoenix's environment variables.\n"

echo_red_text "Your system will now reboot to finalize your changes."
"${PHOENIX_INSTALL_SLEEP}" 5 || error_fn
echo
echo_green_text "Press enter to continue."
read

"${PHOENIX_INSTALL_SUDO}" /sbin/reboot
