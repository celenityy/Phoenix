#!/bin/zsh

wget https://phoenix.celenity.dev/mozilla.cfg

sudo mv mozilla.cfg /Applications/Firefox.app/Contents/Resources/mozilla.cfg

wget https://phoenix.celenity.dev/defaults/pref/local-settings.js

sudo mkdir -p /Applications/Firefox.app/Contents/Resources/defaults/pref

sudo chmod 755 /Applications/Firefox.app/Contents/Resources/defaults/pref

sudo mv local-settings.js /Applications/Firefox.app/Contents/Resources/defaults/pref/local-settings.js

brew tap celenity/Phoenix-Policies-macOS https://codeberg.org/celenity/Phoenix-Policies-macOS

brew update

brew upgrade --force

brew install phoenix-policies

cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json

cat << 'EOF' > /usr/local/sbin/update_policies_phoenix.sh
#!/bin/zsh
cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json
EOF

sudo chmod +x /usr/local/sbin/update_policies_phoenix.sh

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
EOF

launchctl load ~/Library/LaunchAgents/com.user.updatepoliciesphoenix.plist

echo 'alias phoenix-up="cp /opt/homebrew/opt/phoenix-policies/etc/firefox/distribution/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json"' >> ~/.zshrc

printf "All done. :) Congratulations, you've successfully installed Phoenix.\nWhat comes next is for you to decide. I would strongly recommend taking a look at some of the user.js files we offer, such as our 'Hardened' option for more comprehensive protection, at the cost of minimal breakage.\nYou can learn more here https://phoenix.celenity.dev/#complete-coverage.\n"

printf "NOTE: Due to macOS limitations, by default, your policies will only update every 6 hours or on device boot. If you want to enforce a policies update, you can run "phoenix-up" after the update is downloaded download with Homebrew.\nYou can also set an alias in your ~/.zshrc to make this easier, such as:\nalias update='brew update && brew upgrade --force && phoenix-up'"