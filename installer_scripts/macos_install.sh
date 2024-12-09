#!/bin/env bash


## Downloaded files save in /tmp for moving
cd /tmp


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

## Install Phoenix
echo_green_text "Downloading phoenix.cfg..."
wget -nv https://phoenix.celenity.dev/phoenix.cfg || error_fn
echo

echo_green_text "Moving phoenix.cfg to /Applications/Firefox.app/Contents/Resources/phoenix.cfg..."
sudo mv -v phoenix.cfg /Applications/Firefox.app/Contents/Resources/phoenix.cfg || error_fn
echo

echo_green_text "Downloading phoenix.js..."
wget -nv https://phoenix.celenity.dev/defaults/pref/phoenix.js || error_fn
echo

echo_green_text "Creating /Applications/Firefox.app/Contents/Resources/defaults/pref directory..."
sudo mkdir -v -p /Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
echo

echo_green_text "Changing permissions of /Applications/Firefox.app/Contents/Resources/defaults/pref to 655..."
sudo chmod -v 655 /Applications/Firefox.app/Contents/Resources/defaults/pref || error_fn
echo

echo_green_text "Moving phoenix.js to /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js..."
sudo mv -v phoenix.js /Applications/Firefox.app/Contents/Resources/defaults/pref/phoenix.js || error_fn
echo

echo_green_text "Adding celenity's Tap to Homebrew..."
brew tap celenity/tap https://codeberg.org/celenity/tap || error_fn
echo

echo_green_text "Updating Homebrew cache..."
brew update && brew upgrade --force --verbose || error_fn
echo

echo_green_text "Installing phoenix-policies package..."
brew install phoenix-policies || error_fn
echo

echo_green_text "Moving Phoenix's policies.json from /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json to /Applications/Firefox.app/Contents/Resources/distribution/policies.json..."
cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json || error_fn
echo

echo_green_text "Creating a script to automatically copy Phoenix's policies.json from /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json to /Applications/Firefox.app/Contents/Resources/distribution/policies.json for updates..."
cat << 'EOF' > /usr/local/sbin/update_policies_phoenix.sh
#!/bin/zsh
cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json
EOF || error_fn
echo

echo_green_text "Making /usr/local/sbin/update_policies_phoenix.sh executable..."
sudo chmod +x /usr/local/sbin/update_policies_phoenix.sh || error_fn
echo

echo_green_text "Creating a launch agent to automatically copy Phoenix's policies.json from /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json to /Applications/Firefox.app/Contents/Resources/distribution/policies.json for updates..."
cat << 'EOF' > ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.updatepoliciesphoenix</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/local/sbin/update_policies_phoenix.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StartInterval</key>
    <integer>21600</integer> <!-- 6 hours in seconds -->
</dict>
</plist>
EOF || error_fn
echo

echo_green_text "Loading  ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist..."
launchctl load ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist || error_fn
echo

echo_green_text "Setting a 'phoenix-up' alias to easily update Phoenix's policies..."
echo 'alias phoenix-up="cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json"' >> ~/.zshrc | error_fn
echo

echo_green_text "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#complete-coverage.\n"

echo_green_text "NOTE: Due to macOS limitations, by default, your policies will only update every 6 hours or on device boot. If you want to enforce a policies update, you can run "phoenix-up" after the update is downloaded download with Homebrew.\nYou can also set an alias in your ~/.zshrc to make this easier, such as:\nalias update='brew update && brew upgrade --force --verbose && phoenix-up'"
