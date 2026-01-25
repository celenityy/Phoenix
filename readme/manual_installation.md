# 📛Manual Installation

> [!CAUTION]
>**This is NOT recommended for most users.**

By default, Phoenix is installed & updated via your operating system's package manager. This allows for fast, easy updates & fixes as needed, right with the rest of your system!

However, if this is not desirable for you & your situation, or you would simply like to use Phoenix on an unsupported operating system, you can manually install Phoenix with the following steps:

**1:** Download `phoenix.cfg` for your platform:

- Linux: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/phoenix.cfg`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/phoenix.cfg)
- macOS: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/macos/phoenix.cfg`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/macos/phoenix.cfg)
- Windows: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/phoenix.cfg`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/phoenix.cfg)

You can right click and select `Save page as` from your browser after navigating to the link for your platform's `phoenix.cfg`, or you can run the following command in your terminal:

**Linux**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/phoenix.cfg
```

**macOS**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/macos/phoenix.cfg
```

**Windows**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/phoenix.cfg
```

**2:** Download `phoenix.js` *(`phoenix-desktop.js` for Linux users)* for your platform:

- Linux: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/defaults/pref/phoenix-desktop.js`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/defaults/pref/phoenix-desktop.js)
- macOS: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/defaults/pref/phoenix.js`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/defaults/pref/phoenix.js)
- Windows: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/defaults/pref/phoenix.js`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/defaults/pref/phoenix.js)

You can right click and select `Save page as` from your browser after navigating to the link for your platform's `phoenix.js` *(or `phoenix-desktop.js` for Linux users)*, or you can run the following command in your terminal:

**Linux**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/defaults/pref/phoenix-desktop.js
```

**macOS**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/defaults/pref/phoenix.js
```

**Windows**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/defaults/pref/phoenix.js
```

**3:** Download `policies.json` *(or `org.mozilla.firefox.plist` for macOS users)* for your platform:

- Linux: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/policies/policies.json`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/policies/policies.json)
- macOS: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/macos/org.mozilla.firefox.plist`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/macos/org.mozilla.firefox.plist)
- Windows: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/distribution/policies.json`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/distribution/policies.json)

You can right click and select `Save page as` from your browser after navigating to the link for your platform's `policies.json` *(or `org.mozilla.firefox.plist` for macOS users)*, or you can run the following command in your terminal:

**Linux**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/policies/policies.json
```

**macOS**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/macos/macos/org.mozilla.firefox.plist
```

**Windows**:

```sh
curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/distribution/policies.json
```

**4:** Locate your Firefox installation directory. This will vary depending on your platform. An easy way to find it is by navigating to `about:support` and checking the directory next to `Application Binary`. For example, on Fedora Linux, I see `/usr/lib64/firefox/firefox` next to `Application Binary`. This means our installation directory is `/usr/lib64/firefox`.

> [!CAUTION]
>**Unless you're on Fedora Linux, your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**5:** Move `phoenix.cfg` to the **root** of your installation directory. You can either drag and drop it manually, or run the following command for your platform:

**Linux/macOS**, *assuming `/usr/lib64/firefox` is your installation directory*:

```sh
sudo cp phoenix.cfg /usr/lib64/firefox/phoenix.cfg
```

**Windows**:

```sh
cp phoenix.cfg C:\'Program Files'\'Mozilla Firefox'\phoenix.cfg
```

**6:** **For macOS, Windows, and Flatpak users**: If it does not already exist, in the **root** of your installation directory, create a folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. You can do this manually through your file explorer, or you can run the following command for your platform:

**Flatpak/macOS**, *assuming `/usr/lib64/firefox` is your installation directory*:

```sh
sudo mkdir -p /usr/lib64/firefox/defaults/pref
```

**Windows**:

```sh
mkdir -p C:\'Program Files'\'Mozilla Firefox'\defaults\pref
```

**For standard Linux users:** If it does not already exist, you will want to create a folder named `firefox` located in your system's `etc` directory. Inside this `firefox` folder, create a new folder named `defaults`, and inside this new `defaults` folder, create another folder titled `pref`. This will work **regardless of your distribution** - even Snaps are supported. You can also just run the command below:

```sh
sudo mkdir -p /etc/firefox/defaults/pref
```

On macOS and GNU/Linux, you'll also want to ensure that the folder you created has proper permissions:

**Flatpak/macOS**, *assuming `/usr/lib64/firefox` is your installation directory*:

```sh
sudo chmod 744 /usr/lib64/firefox/defaults/pref
```

**For all non-Flatpak GNU/Linux users:**

```sh
sudo chmod 655 /etc/firefox/defaults/pref
```

**7:** Move `phoenix.js` *(or `phoenix-desktop.js` for Linux users)* to the `pref` folder that you just created. You can run the following command for your platform below:

**Linux/macOS**, *Assuming your installation directory is `/usr/lib64/firefox`*:

```sh
sudo cp phoenix-desktop.js /usr/lib64/firefox/defaults/pref/phoenix-desktop.js
```

**Windows**:

```sh
cp phoenix.js C:\'Program Files'\'Mozilla Firefox'\defaults\pref\phoenix.js
```

**For all non-Flatpak GNU/Linux users:**

```sh
sudo cp phoenix-desktop.js /etc/firefox/defaults/pref/phoenix-desktop.js
```

**8:** On Windows, in the **root** of your installation directory, create a folder named `distribution`. You can do this manually through your file explorer, or you can run the following command:

```sh
mkdir -p C:\'Program Files'\'Mozilla Firefox'\distribution
```

non-Flatpak GNU/Linux users should **instead** create a `policies` folder inside of the `firefox` folder located in `/etc`. This will work **regardless** of your distribution, and even for Snaps.

```sh
sudo mkdir -p /etc/firefox/policies
```

For non-Flatpak GNU/Linux users, you'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/firefox/policies
```

**9:** Finally, those on Windows should copy `policies.json` to the `distribution` folder that you just created. You can run the following command:

```sh
cp policies.json C:\'Program Files'\'Mozilla Firefox'\distribution\policies.json
```

macOS users should **instead** copy `org.mozilla.firefox.plist` to `/Library/Preferences`, and **reboot** their device once finished:

```sh
sudo cp org.mozilla.firefox.plist /Library/Preferences/org.mozilla.firefox.plist`
```

GNU/Linux users should **instead** copy `policies.json` to their `/etc/firefox/policies` folder they just created.

```sh
sudo cp policies.json /etc/firefox/policies/policies.json
```

Congratulations, you're done. Enjoy Phoenix, and be sure to keep up with updates!
