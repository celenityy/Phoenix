# 📛 Manual Installation

> [!CAUTION]
>**This is NOT recommended for most users.**

By default, Phoenix is installed & updated via your operating system's package
manager. This allows for fast, easy updates & fixes as needed, right with the
rest of your system!

However, if this is not desirable for you & your situation, or you would simply
like to use Phoenix on an unsupported operating system, you can manually install
Phoenix with the following steps:

## List

1. [Linux](#linux)
2. [macOS](#macos)
3. [Windows](#windows)

### Linux

**1:** Download `phoenix.cfg` for Linux:

- Linux: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/phoenix.cfg`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/phoenix.cfg)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `phoenix.cfg`, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/phoenix.cfg
```

**2:** Download `phoenix-desktop.js` for Linux:

- Linux: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/defaults/pref/phoenix-desktop.js`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/defaults/pref/phoenix-desktop.js)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `phoenix-desktop.js`, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/defaults/pref/phoenix-desktop.js
```

**3:** Download `policies.json` for Linux:

- Linux: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/policies/policies.json`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/policies/policies.json)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `policies.json`, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/linux/policies/policies.json
```

**4:** Locate your Firefox installation directory. This will vary depending on
your platform. An easy way to find it is by navigating to `about:support` and
checking the directory next to `Application Binary`. For example, on Fedora
Linux, I see `/usr/lib64/firefox/firefox` next to `Application Binary`. This
means our installation directory is `/usr/lib64/firefox`.

> [!CAUTION]
>**Unless you're on Fedora Linux, your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**5:** Move `phoenix.cfg` to the **root** of your installation directory. You
can either drag and drop it manually, or run the following command:
*assuming `/usr/lib64/firefox` is your installation directory*

```sh
sudo cp phoenix.cfg /usr/lib64/firefox/phoenix.cfg
```

**6:** If it does not already exist, you will want to
create a folder named `firefox` located in your system's `etc` directory. Inside
this `firefox` folder, create a new folder named `defaults`, and inside this new
`defaults` folder, create another folder titled `pref`. This will work
**regardless of your distribution** - even Snaps are supported. You can also
just run the command below:

```sh
sudo mkdir -p /etc/firefox/defaults/pref
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/firefox/defaults/pref
```

**7:** Move `phoenix-desktop.js` to the
`pref` folder that you just created. You can run the following command:

```sh
sudo cp phoenix-desktop.js /etc/firefox/defaults/pref/phoenix-desktop.js
```

**8:** Non-Flatpak GNU/Linux users should **instead** create a `policies` folder
inside of the `firefox` folder located in `/etc`. This will work **regardless**
of your distribution, and even for Snaps.

```sh
sudo mkdir -p /etc/firefox/policies
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/firefox/policies
```

**9:** Finally, copy `policies.json` to your
`/etc/firefox/policies` folder you just created.

```sh
sudo cp policies.json /etc/firefox/policies/policies.json
```

### macOS

**1:** Download `phoenix.cfg` for macOS:

- macOS: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/macos/phoenix.cfg`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/macos/phoenix.cfg)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `phoenix.cfg`, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/macos/phoenix.cfg
```

**2:** Download `phoenix.js` for macOS:

- macOS: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/defaults/pref/phoenix.js`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/defaults/pref/phoenix.js)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `phoenix.js`, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/defaults/pref/phoenix.js
```

**3:** Download `org.mozilla.firefox.plist` for macOS:

- macOS: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/macos/org.mozilla.firefox.plist`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/macos/org.mozilla.firefox.plist)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `org.mozilla.firefox.plist`, or you can run the
following command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/macos/org.mozilla.firefox.plist
```

**4:** Locate your Firefox installation directory. This will vary depending on
your platform. An easy way to find it is by navigating to `about:support` and
checking the directory next to `Application Binary`.

> [!CAUTION]
>**Your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**5:** Move `phoenix.cfg` to the **root** of your installation directory. You
can either drag and drop it manually, or run the following command:
*assuming `/usr/lib64/firefox` is your installation directory*

```sh
sudo cp phoenix.cfg /usr/lib64/firefox/phoenix.cfg
```

**6:** If it does not already exist,
in the **root** of your installation directory, create a folder named
`defaults`, and inside this new `defaults` folder, create another folder titled
`pref`. You can do this manually through your file explorer, or you can run the
following command:
*assuming `/usr/lib64/firefox` is your installation directory*

```sh
sudo mkdir -p /usr/lib64/firefox/defaults/pref
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 744 /usr/lib64/firefox/defaults/pref
```

**7:** Move `phoenix.js` to the
`pref` folder that you just created. You can run the following command:
*Assuming your installation directory is `/usr/lib64/firefox`*

```sh
sudo cp phoenix.js /usr/lib64/firefox/defaults/pref/phoenix.js
```

**9:** Finally, copy `org.mozilla.firefox.plist` to
`/Library/Preferences`, and **reboot** your device once finished:

```sh
sudo cp org.mozilla.firefox.plist /Library/Preferences/org.mozilla.firefox.plist
```

### Windows

**1:** Download `phoenix.cfg` for Windows:

- Windows: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/phoenix.cfg`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/phoenix.cfg)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `phoenix.cfg`, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/phoenix.cfg
```

**2:** Download `phoenix.js` for Windows:

- Windows: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/defaults/pref/phoenix.js`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/defaults/pref/phoenix.js)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `phoenix.js`, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/defaults/pref/phoenix.js
```

**3:** Download `policies.json` for Windows:

- Windows: [`https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/distribution/policies.json`](https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/distribution/policies.json)

You can right click and select `Save page as` from your browser after navigating
to the link for your platform's `policies.json`, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/windows/distribution/policies.json
```

**4:** Locate your Firefox installation directory. This will vary depending on
your platform. An easy way to find it is by navigating to `about:support` and
checking the directory next to `Application Binary`.

> [!CAUTION]
>**Your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**5:** Move `phoenix.cfg` to the **root** of your installation directory. You
can either drag and drop it manually, or run the following command:

```sh
cp phoenix.cfg C:\'Program Files'\'Mozilla Firefox'\phoenix.cfg
```

**6:** If it does not already exist,
in the **root** of your installation directory, create a folder named
`defaults`, and inside this new `defaults` folder, create another folder titled
`pref`. You can do this manually through your file explorer, or you can run the
following command:

```sh
mkdir -p C:\'Program Files'\'Mozilla Firefox'\defaults\pref
```

**7:** Move `phoenix.js` to the
`pref` folder that you just created. You can run the following command:

```sh
cp phoenix.js C:\'Program Files'\'Mozilla Firefox'\defaults\pref\phoenix.js
```

**8:** In the **root** of your installation directory, create a
folder named `distribution`. You can do this manually through your file
explorer, or you can run the following command:

```sh
mkdir -p C:\'Program Files'\'Mozilla Firefox'\distribution
```

**9:** Finally, copy `policies.json` to the
`distribution` folder that you just created. You can run the following command:

```sh
cp policies.json C:\'Program Files'\'Mozilla Firefox'\distribution\policies.json
```

## 🤔 Extended / Specialized

With a manual installation of Phoenix, if you would like to use Phoenix's
[extended](Extended.md) config, or one of our
[specialized configs](SpecializedConfigs.md), you'll need to follow these steps.

**1:** Download the `.cfg` file of your choice for your platform:

- Linux: [See here](https://gitlab.com/celenityy/Phoenix/-/tree/pages/linux/configs).
- macOS: [See here](https://gitlab.com/celenityy/Phoenix/-/tree/pages/osx/configs).
- Windows: [See here](https://gitlab.com/celenityy/Phoenix/-/tree/pages/windows/configs).

For this example, we'll use `youtube.cfg`. **Simply replace mentions of
`youtube.cfg` below with the configuration you would like to use.**

You can right click and select `Save page as` from your browser on the `.cfg`
file, or you can run the following command in your terminal:

```sh
wget https://gitlab.com/celenityy/Phoenix/-/raw/pages/configs/youtube.cfg
```

**2:** Store the `.cfg` file you just downloaded somewhere safe that you can
remember. For this example, we'll keep it simple and say I chose to save
`youtube.cfg` at `~/youtube.cfg`. **Replace mentions of `~/youtube.cfg` below
with the actual location of your file.**

You can either drag and drop the file manually, or run the command below:

```sh
cp youtube.cfg ~/youtube.cfg
```

**3:** Download [the `user.js` file](https://gitlab.com/celenityy/Phoenix/-/raw/pages/user.js).

You can right click and select `Save page as` from your browser on the `user.js`
file, or you can run the following command in your terminal:

```sh
wget https://gitlab.com/celenityy/Phoenix/-/raw/pages/user.js
```

**4:** Edit the `user.js` file you just downloaded, and replace
**file://`put_your_cfg_file_location_here`** with the location of your `.cfg`
file from Step 2.

Assuming our file is still located at `~/youtube.cfg` and our username is
`user`, we'll change the contents of the `user.js` file we downloaded to:

```sh
user_pref("autoadmin.global_config_url", "file:///home/user/youtube.cfg");
```

**5:** Find your Firefox profile's directory. This depends on your platform, but
an easy way to find it is by navigating to `about:profiles`, and it'll be the
path listed beside **Root Directory**. For example's sake, we'll say our
profile's directory is `/home/${USER}/.mozilla/firefox/153acxao.default-release`.
**Yours will be different, and you should replace this path on the next step
with your actual profile directory's path.**

**6:** Simply copy & paste your `user.js` file to your profile's directory! You
can either drag and drop it manually, or run the command below. For example's
sake, we'll say our user.js is located at `~/Downloads/user.js`. **If this is
not the path of your downloaded `user.js` file from Step 3, replace it with its
actual location.**

```sh
cp ~/Downloads/user.js /home/${USER}/.mozilla/firefox/153acxao.default-release/user.js
```

## End

Congratulations, you're done!
Enjoy Phoenix, and be sure to keep up with updates!
