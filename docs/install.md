# Install

> [!IMPORTANT]
> ⚠️ After Phoenix is installed, you **MUST** restart Firefox after its first
> run with Phoenix installed. **This ensures all of Phoenix's changes are applied...**

## Support

| Platform | Derivatives | Firefox Support                   | Support Status                                            |
|----------|-------------|-----------------------------------|-----------------------------------------------------------|
| Android  | -           | [IronFox](https://ironfoxoss.org) | Official                                                  |
| Arch     | Partial     | Firefox                           | Official + Community                                      |
| Debian   | Yes         | Firefox: bin, ESR                 | Official                                                  |
| Fedora   | No          | Firefox                           | Official                                                  |
| Flatpak  | -           | org.mozilla.firefox               | [Broken](https://codeberg.org/celenity/Phoenix/issues/5)  |
| Gentoo   | Yes         | Firefox: bin, source              | Community                                                 |
| NixOS    | -           | Firefox                           | Official + Community                                      |
| macOS    | -           | Firefox                           | Official                                                  |
| Ubuntu   | Yes         | Firefox                           | Official                                                  |
| Windows  | -           | Firefox, Zen                      | [Partial](https://codeberg.org/celenity/Phoenix/issues/3) |

Also see: [Repology](https://repology.org/project/phoenix-firefox/versions).

Other platforms have unfortunately proven difficult to support, though progress
**is** being made. Contributions are always welcome and appreciated.

## Table of Contents

### Auto

- [Arch Linux](#arch-linux)
- [Debian/Ubuntu-based](#debianubuntu-and-derivatives)
- [Fedora-based](#fedora-linux)
- [macOS: Homebrew](#macos-homebrew)
- [NixOS](#nixos)

### Manual

- [Manual: Linux](#manual-linux)
- [Manual: macOS](#manual-macos)
- [Manual: Windows](#manual-windows)

## Install: Auto

> [!NOTE]
> ⚠️ **Flatpak *(User)* & Snap packages of Firefox are currently not supported.**

> [!IMPORTANT]
> **Android users are recommended to install
> [IronFox](https://gitlab.com/ironfox-oss/IronFox) *(Recommended)*, which uses
> Phoenix for its configs. Android users can also manually install Phoenix for
> any Firefox-based browser on Android via [directions](https://phoenix.celenity.dev/android).**

### Arch Linux

```sh
# You can use `paru` instead of `yay` with the same options.

# Pacman:
yay -S phoenix-arch

# Pacman (System Flatpak):
yay -S phoenix-flatpak
```

### Debian/Ubuntu and derivatives

 Before installing Phoenix, you'll first need to add [celenity's OBS repo](https://build.opensuse.org/project/show/home:celenity):

> [!NOTE]
> You may see a warning, such as the following, when updating your `apt` cache.
>
> ```sh
> Warning: https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/InRelease: Policy will reject signature within a year, see --audit for details
> ```
>
> This is because `apt` will not support V3 GPG keys after `2026-02-01`, and
> currently the OBS uses a V3 GPG key. For now, there shouldn't be any issues.

 ```sh
 echo 'deb https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/ /' | sudo tee /etc/apt/sources.list.d/home:celenity.list
 wget -O- https://download.opensuse.org/repositories/home:celenity/Debian_Unstable/Release.key 2>/dev/null | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null
 sudo apt update
 ```

```sh
# APT:
sudo apt install phoenix

# APT (System Flatpak):
sudo apt install phoenix-flatpak
```

### Fedora Linux

Before installing Phoenix, you'll first need to add [celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr):

 ```sh
sudo dnf copr enable celenity/copr && sudo dnf makecache

# RPM:
sudo dnf install phoenix

# RPM (System Flatpak):
sudo dnf install phoenix-flatpak
```

### macOS: Homebrew

> [!IMPORTANT]
> ⚠️ **Before proceeding, you must have [Homebrew](https://brew.sh) installed.**

```sh
/bin/zsh -c "$(curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/scripts/osx_install.sh)"
```

### NixOS

NixOS is supported for [flake-based configurations](https://wiki.nixos.org/wiki/Flakes#Using_nix_flakes_with_NixOS):

1. Add the Phoenix repository to your flake inputs.
2. Add `phoenix` as one of the arguments to your output function.
3. Add the Phoenix NixOS Module to your configuration.

```nix
{
  inputs = {
    # Note that this assumes you have a flake-input called nixpkgs,
    # which is often the case. If you've named it something else,
    # you'll need to change the `nixpkgs` below.
    phoenix = {
      url = "git+https://gitlab.com/celenityy/Phoenix?ref=pages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  # Add the `phoenix` argument to your output function, as below:
  outputs = {nixpkgs, phoenix, ...}: {
 # The configuration here is an example; it will look slightly different
 # based on your machine name and architecture.
    nixosConfigurations.your-box = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # This is the important part -- add this line to your module list!
        phoenix.nixosModules.default
      ];
 };
  };
}
```

Alternatively, the Phoenix package, overlay, and NixOS module can be used
directly in both flake and non-flake contexts. Simply pin the Phoenix source
repository using your tool of choice (e.g. niv, npins, flakes) and then include
`nix/package.nix`, `nix/overlay.nix`, or `nix/module.nix` as desired.

## 📛 Manual Installation

> [!CAUTION]
> **This is NOT recommended for most users.**

By default, Phoenix is installed and updated via your operating system's package
manager. This allows for fast, easy updates & fixes as needed, right with the
rest of your system!

However, if this is not desirable for you and your situation, or you would simply
like to use Phoenix on an unsupported operating system, you can manually install
Phoenix with the following steps:

### Manual: Linux

**1:** Download the archive for your desired Phoenix release:

This can be found at the link below *(replacing `{PHOENIX_VERSION}`
with the version of Phoenix you'd like to download)*.
For reference, the latest version of Phoenix can always be
found at the top of [the `Releases` page](https://codeberg.org/celenity/Phoenix/releases).

You can navigate to the link and download the archive
directly from your web browser, or you can run the following
command in your terminal:

```text
https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/linux/phoenix-{PHOENIX_VERSION}-linux.tar.xz
```

```sh
curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -O -sSL https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/linux/phoenix-{PHOENIX_VERSION}-linux.tar.xz
```

**2:** Extract your downloaded archive:

First, create the directory where you'd like to extract Phoenix:

```sh
cd ~/Downloads # or where you downloaded the archive
mkdir -p phoenix && tar -xvf phoenix-{PHOENIX_VERSION}-linux.tar.xz -C phoenix
```

**3:** If it does not already exist, you will want to
create a folder named `firefox` located in your system's `etc` directory.
This will work **regardless of your distribution** - even Snaps are supported.

```sh
sudo mkdir -p /etc/firefox && sudo chmod 655 /etc/firefox
```

**4:** Copy `phoenix.cfg` to the `/etc/firefox` directory you just created.
You can either drag and drop it manually, or run the following command:

**NOTE**: If you have previously installed `phoenix.cfg` to a different location
*(such as Firefox's installation directory)*,
**please REMOVE it** to ensure any conflicts are avoided.

```sh
sudo cp phoenix/phoenix.cfg /etc/firefox/phoenix.cfg
```

**5:** If it does not already exist, inside the `/etc/firefox` directory,
create a new folder named `defaults`, and inside this new `defaults` folder,
create another folder titled `pref`. This will work
**regardless of your distribution** - even Snaps are supported.

```sh
sudo mkdir -p /etc/firefox/defaults/pref && sudo chmod 655 /etc/firefox/defaults/pref
```

**6:** Copy `phoenix.js` to the
`pref` folder that you just created. You can run the following command:

**NOTE**: If you have a `phoenix-desktop.js` in this directory,
**please REMOVE it** to ensure any conflicts are avoided.

```sh
sudo cp phoenix/defaults/pref/phoenix.js /etc/firefox/defaults/pref/phoenix.js
```

**7:** Non-Flatpak GNU/Linux users should **instead** create a `policies` folder
inside of the `firefox` folder located in `/etc`. This will work **regardless**
of your distribution, and even for Snaps.

```sh
sudo mkdir -p /etc/firefox/policies && sudo chmod 655 /etc/firefox/policies
```

**8:** Finally, copy `policies.json` to your
`/etc/firefox/policies` folder you just created.

```sh
sudo cp phoenix/policies/policies.json /etc/firefox/policies/policies.json
```

### Manual: macOS

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
*assuming `/Users/${USER}/Applications/Firefox.app` is your installation directory*

```sh
sudo cp phoenix/macos/phoenix.cfg /Users/${USER}/Applications/Firefox.app/Resources/phoenix.cfg
```

**5:** If it does not already exist, inside the `Resources` directory, create a new folder named `defaults`,
and inside this new `defaults` folder, create another folder titled `pref`.
You can do this manually through your file explorer, or you can run the following command:
*assuming `/Users/${USER}/Applications/Firefox.app` is your installation directory*

```sh
sudo mkdir -p /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref
```

You'll also want to ensure that the folder you created has proper permissions:

```sh
sudo chmod 744 /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref
```

**6:** Copy `defaults/pref/phoenix.js` to the
`pref` folder that you just created. You can run the following command:
*Assuming your installation directory is `/Users/${USER}/Applications/Firefox.app`*

```sh
sudo cp phoenix/defaults/pref/phoenix.js /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref/phoenix.js
```

**7:** Finally, copy `macos/org.mozilla.firefox.plist` to
`/Library/Preferences`, and **reboot** your device once finished:

```sh
sudo cp phoenix/macos/org.mozilla.firefox.plist /Library/Preferences/org.mozilla.firefox.plist
```

### Manual: Windows

**1:** Download the archive for your desired Phoenix release:

This can be found at the link below *(replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to download)*. For reference, the latest version of Phoenix can always be found at the top of [the `Releases` page](https://codeberg.org/celenity/Phoenix/releases).

- `https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/windows/phoenix-{PHOENIX_VERSION}-windows.zip`

You can navigate to the link above and download the archive
directly from your web browser, or you can run the following
command in your terminal:

```powershell
Invoke-WebRequest -UserAgent '' -Uri 'https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/windows/phoenix-{PHOENIX_VERSION}-windows.zip' -OutFile 'phoenix-{PHOENIX_VERSION}-windows.zip'
```

**2:** Extract your downloaded archive:

First, create the directory where you'd like to extract Phoenix:

```powershell
New-Item -ItemType 'Directory' -Name 'phoenix'
```

Now, extract the downloaded archive:

*(Replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to download, and `\Path\To` with the path to your downloaded archive)*

```powershell
Expand-Archive -Path '\Path\To\phoenix-{PHOENIX_VERSION}-windows.zip' -DestinationPath 'phoenix'
```

**4:** Locate your Firefox installation directory. This will vary depending on
your platform. An easy way to find it is by navigating to `about:support` and
checking the directory next to `Application Binary`.

> [!CAUTION]
> **Your directory will probably be different, and you should replace this directory on the following steps with your actual installation directory.**

**5:** Copy `phoenix.cfg` to the **root** of your installation directory. You
can either drag and drop it manually, or run the following command:

```powershell
Copy-Item -Path 'phoenix\phoenix.cfg' -Destination 'C:\Program Files\Mozilla Firefox\'
```

**6:** If it does not already exist,
in the **root** of your installation directory, create a folder named
`defaults`, and inside this new `defaults` folder, create another folder titled
`pref`. You can do this manually through your file explorer, or you can run the
following command:

```powershell
New-Item -Path 'C:\Program Files\Mozilla Firefox\' -ItemType 'Directory' -Name 'defaults\pref'
```

**7:** Copy `defaults\pref\phoenix.js` to the
`pref` folder that you just created. You can run the following command:

```powershell
Copy-Item -Path 'phoenix\defaults\pref\phoenix.js' -Destination 'C:\Program Files\Mozilla Firefox\defaults\pref\'
```

**8:** In the **root** of your installation directory, create a
folder named `distribution`. You can do this manually through your file
explorer, or you can run the following command:

```powershell
New-Item -Path 'C:\Program Files\Mozilla Firefox\' -ItemType 'Directory' -Name 'distribution'
```

**9:** Finally, copy `distribution\policies.json` to the
`distribution` folder that you just created. You can run the following command:

```powershell
Copy-Item -Path 'phoenix\distribution\policies.json' -Destination 'C:\Program Files\Mozilla Firefox\distribution\'
```

## End

Congratulations, you're done!
Enjoy Phoenix, and be sure to keep up with updates!
