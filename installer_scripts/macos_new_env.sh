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

echo_green_text "Welcome to the new environment variable set-up script!"

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
sudo /bin/cp dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_CRASHREPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
sudo /bin/cp dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.phoenix.env.MOZ_DISABLE_ASAN_REPORTER.plist || error_fn
echo

echo_green_text "Downloading dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Changing permissions of dev.celenity.phoenix.env.SSLKEYLOGFILE.plist to 644..."
sudo /bin/chmod -v 644 dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Copying dev.celenity.phoenix.env.SSLKEYLOGFILE.plist to /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
sudo /bin/cp dev.celenity.phoenix.env.SSLKEYLOGFILE.plist /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "Loading dev.celenity.phoenix.env.SSLKEYLOGFILE.plist..."
/bin/launchctl load /Library/LaunchAgents/dev.celenity.phoenix.env.SSLKEYLOGFILE.plist || error_fn
echo

echo_green_text "All done. :D"

echo_red_text "Your system will now reboot to finalize our changes."
/bin/sleep 5
echo_green_text "Press enter to continue."
read

sudo /sbin/reboot
