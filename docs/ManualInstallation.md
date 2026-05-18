# 📛 Manual Installation

> [!CAUTION]
> **This is NOT recommended for most users.**

By default, Phoenix is installed and updated via your operating system's package
manager. This allows for fast, easy updates & fixes as needed, right with the
rest of your system!

However, if this is not desirable for you and your situation, or you would simply
like to use Phoenix on an unsupported operating system, you can manually install
Phoenix with the following steps:

## List

1. [Linux](#linux)
2. [macOS](#macos)
3. [Windows](#windows)

### Linux

**1:** Download the archive for your desired Phoenix release:

This can be found at the link below *(replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to download)*. For reference, the latest version of Phoenix can always be found at the top of [the `Releases` page](https://codeberg.org/celenity/Phoenix/releases).

- `https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/linux/phoenix-{PHOENIX_VERSION}-linux.tar.xz`

You can navigate to the link above and download the archive
directly from your web browser, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/linux/phoenix-{PHOENIX_VERSION}-linux.tar.xz
```

**2:** Extract your downloaded archive:

First, create the directory where you'd like to extract Phoenix:

```sh
mkdir -p phoenix
```

Now, extract the downloaded archive:

*(Replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to download, and `/path/to` with the path to your downloaded archive)*

```sh
tar xJf /path/to/phoenix-{PHOENIX_VERSION}-linux.tar.xz -C phoenix
```

**3:** If it does not already exist, you will want to
create a folder named `firefox` located in your system's `etc` directory.
This will work **regardless of your distribution** - even Snaps are supported.
You can also just run the command below:

```sh
sudo mkdir -p /etc/firefox
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/firefox
```

**4:** Copy `phoenix.cfg` to the `/etc/firefox` directory you just created. You
can either drag and drop it manually, or run the following command:

**NOTE**: If you have previously installed `phoenix.cfg` to a different location _(such as Firefox's installation directory)_, **please REMOVE it** to ensure any conflicts are avoided.

```sh
sudo cp phoenix/phoenix.cfg /etc/firefox/phoenix.cfg
```

**5:** If it does not already exist, inside the `/etc/firefox` directory, create a new folder named `defaults`,
and inside this new `defaults` folder, create another folder titled `pref`. This will work
**regardless of your distribution** - even Snaps are supported. You can also
just run the command below:

```sh
sudo mkdir -p /etc/firefox/defaults/pref
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/firefox/defaults/pref
```

**6:** Copy `phoenix.js` to the
`pref` folder that you just created. You can run the following command:

**NOTE**: If you have a `phoenix-desktop.js` in this directory, **please REMOVE it** to ensure any conflicts are avoided.

```sh
sudo cp phoenix/defaults/pref/phoenix.js /etc/firefox/defaults/pref/phoenix.js
```

**7:** Non-Flatpak GNU/Linux users should **instead** create a `policies` folder
inside of the `firefox` folder located in `/etc`. This will work **regardless**
of your distribution, and even for Snaps.

```sh
sudo mkdir -p /etc/firefox/policies
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 655 /etc/firefox/policies
```

**8:** Finally, copy `policies.json` to your
`/etc/firefox/policies` folder you just created.

```sh
sudo cp phoenix/policies/policies.json /etc/firefox/policies/policies.json
```

### macOS

**1:** Download the archive for your desired Phoenix release:

This can be found at the link below *(replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to download)*. For reference, the latest version of Phoenix can always be found at the top of [the `Releases` page](https://codeberg.org/celenity/Phoenix/releases).

- `https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/osx/phoenix-{PHOENIX_VERSION}-osx.tar.xz`

You can navigate to the link above and download the archive
directly from your web browser, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/osx/phoenix-{PHOENIX_VERSION}-osx.tar.xz
```

**2:** Extract your downloaded archive:

First, create the directory where you'd like to extract Phoenix:

```sh
mkdir -p phoenix
```

Now, extract the downloaded archive:

*(Replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to download, and `/path/to` with the path to your downloaded archive)*

```sh
tar xJf /path/to/phoenix-{PHOENIX_VERSION}-osx.tar.xz -C phoenix
```

**3:** Locate your Firefox installation directory. This will vary depending on
your platform. An easy way to find it is by navigating to `about:support` and
checking the directory next to `Application Binary`.
For example: If I see `/Users/${USER}/Applications/Firefox.app/Contents/MacOS/firefox` listed next to `Application Binary`,
my installation directory would be: **`/Users/${USER}/Applications/Firefox.app`**.

> [!CAUTION]
> **Your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**4:** Copy `macos/phoenix.cfg` to the **`Resources`** folder within your installation directory.
You can either drag and drop it manually, or run the following command:
_assuming `/Users/${USER}/Applications/Firefox.app` is your installation directory_

```sh
sudo cp phoenix/macos/phoenix.cfg /Users/${USER}/Applications/Firefox.app/Resources/phoenix.cfg
```

**5:** If it does not already exist, inside the `Resources` directory, create a new folder named `defaults`,
and inside this new `defaults` folder, create another folder titled `pref`.
You can do this manually through your file explorer, or you can run the following command:
_assuming `/Users/${USER}/Applications/Firefox.app` is your installation directory_

```sh
sudo mkdir -p /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 744 /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref
```

**6:** Copy `defaults/pref/phoenix.js` to the
`pref` folder that you just created. You can run the following command:
_Assuming your installation directory is `/Users/${USER}/Applications/Firefox.app`_

```sh
sudo cp phoenix/defaults/pref/phoenix.js /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref/phoenix.js
```

**7:** Finally, copy `macos/org.mozilla.firefox.plist` to
`/Library/Preferences`, and **reboot** your device once finished:

```sh
sudo cp phoenix/macos/org.mozilla.firefox.plist /Library/Preferences/org.mozilla.firefox.plist
```

### Windows

**1:** Download the archive for your desired Phoenix release:

This can be found at the link below *(replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to download)*. For reference, the latest version of Phoenix can always be found at the top of [the `Releases` page](https://codeberg.org/celenity/Phoenix/releases).

- `https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/windows/phoenix-{PHOENIX_VERSION}-windows.zip`

You can navigate to the link above and download the archive
directly from your web browser, or you can run the following
command in your terminal:

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/windows/phoenix-{PHOENIX_VERSION}-windows.zip
```

**2:** Extract your downloaded archive:

First, create the directory where you'd like to extract Phoenix:

```sh
mkdir -p phoenix
```

Now, extract the downloaded archive:

*(Replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to download, and `/path/to` with the path to your downloaded archive)*

```sh
unzip -q /path/to/phoenix-{PHOENIX_VERSION}-windows.zip -d phoenix
```

**4:** Locate your Firefox installation directory. This will vary depending on
your platform. An easy way to find it is by navigating to `about:support` and
checking the directory next to `Application Binary`.

> [!CAUTION]
> **Your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**5:** Copy `phoenix.cfg` to the **root** of your installation directory. You
can either drag and drop it manually, or run the following command:

```sh
cp phoenix\phoenix.cfg C:\'Program Files'\'Mozilla Firefox'\phoenix.cfg
```

**6:** If it does not already exist,
in the **root** of your installation directory, create a folder named
`defaults`, and inside this new `defaults` folder, create another folder titled
`pref`. You can do this manually through your file explorer, or you can run the
following command:

```sh
mkdir -p C:\'Program Files'\'Mozilla Firefox'\defaults\pref
```

**7:** Copy `defaults/pref/phoenix.js` to the
`pref` folder that you just created. You can run the following command:

```sh
cp phoenix\defaults\pref\phoenix.js C:\'Program Files'\'Mozilla Firefox'\defaults\pref\phoenix.js
```

**8:** In the **root** of your installation directory, create a
folder named `distribution`. You can do this manually through your file
explorer, or you can run the following command:

```sh
mkdir -p C:\'Program Files'\'Mozilla Firefox'\distribution
```

**9:** Finally, copy `distribution/policies.json` to the
`distribution` folder that you just created. You can run the following command:

```sh
cp phoenix\distribution\policies.json C:\'Program Files'\'Mozilla Firefox'\distribution\policies.json
```

## End

Congratulations, you're done!
Enjoy Phoenix, and be sure to keep up with updates!
