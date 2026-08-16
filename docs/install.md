# Phoenix: Install

> [!IMPORTANT]
>
> ⚠️ After Phoenix is installed, you **MUST** restart Firefox after its first
> run with Phoenix installed. **This ensures all of Phoenix's changes are
> applied...**

## Support

| Platform | Derivatives | Stable | ESR | Forks / Other                     | Support Status                                            |
| -------- | ----------- | ------ | --- | --------------------------------- | --------------------------------------------------------- |
| Android  | -           | ✅     | ❌  | [IronFox](https://ironfoxoss.org) | Official                                                  |
| Arch     | Partial     | ✅     | ❌  | -                                 | Official + Community                                      |
| Debian   | Yes         | ✅     | ✅  | -                                 | Official                                                  |
| Fedora   | No          | ✅     | ❌  | -                                 | Official                                                  |
| Flatpak  | -           | ✅     | ❌  | -                                 | [Broken](https://codeberg.org/celenity/Phoenix/issues/5)  |
| Gentoo   | Yes         | ✅     | ✅  | -                                 | Community                                                 |
| macOS    | -           | ✅     | ❌  | -                                 | Official                                                  |
| NixOS    | Yes         | ✅     | ❌  | -                                 | Official + Community                                      |
| Snap     | -           | ❌     | ❌  | -                                 | [Broken](https://codeberg.org/celenity/Phoenix/issues/5)  |
| Ubuntu   | Yes         | ✅     | ✅  | -                                 | Official                                                  |
| Windows  | -           | ✅     | ❌  | Zen Browser                       | [Partial](https://codeberg.org/celenity/Phoenix/issues/3) |

Also see: [Repology](https://repology.org/project/phoenix-firefox/versions).

1. _Flatpak targets `org.mozilla.firefox` package._
2. _Gentoo GNU/Linux supports stable and ESR builds via both binary and source
   compilation._

Other platforms have unfortunately proven difficult to support, though progress
is being made. Contributions are always welcome and appreciated.

## Table of Contents

### Auto

- [Arch Linux](#arch-linux)
- [Debian/Ubuntu-based](#debianubuntu-and-derivatives)
- [Fedora-based](#fedora-linux)
- [Gentoo Linux](#gentoo-linux)
- [macOS: Homebrew](#macos-homebrew)
- [NixOS](#nixos)

### Manual

- [Manual: Linux](#manual-linux)
- [Manual: macOS](#manual-macos)
- [Manual: Windows](#manual-windows)

## Install: Auto

> [!NOTE]
>
> ⚠️ **Flatpak _(User)_ & Snap packages of Firefox are currently not
> supported.**

> [!IMPORTANT]
>
> **Android users are recommended to install
> [IronFox](https://gitlab.com/ironfox-oss/IronFox) _(Recommended)_, which uses
> Phoenix for its configs. Android users can also manually install Phoenix for
> any Firefox-based browser on Android via
> [directions](https://phoenix.celenity.dev/android).**

### Arch Linux

```bash
# You can use `paru` instead of `yay` with the same options.

# Pacman:
yay -S phoenix-arch

# Pacman (System Flatpak):
yay -S phoenix-flatpak
```

### Debian/Ubuntu and derivatives

Before installing Phoenix, you'll first need to add
[celenity's OBS repo](https://build.opensuse.org/project/show/home:celenity):

> [!NOTE]
>
> You may see a warning, such as the following, when updating your `apt` cache.
>
> ```bash
> Warning: https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/InRelease: Policy will reject signature within a year, see --audit for details
> ```
>
> This is because `apt` will not support V3 GPG keys after `2026-02-01`, and
> currently the OBS uses a V3 GPG key. For now, there shouldn't be any issues.

```bash
echo 'deb https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/ /' | sudo tee /etc/apt/sources.list.d/home:celenity.list
wget -O- https://download.opensuse.org/repositories/home:celenity/Debian_Unstable/Release.key 2>/dev/null | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null
apt update
```

```bash
# APT:
apt install phoenix

# APT (System Flatpak):
apt install phoenix-flatpak
```

### Fedora Linux

Before installing Phoenix, you'll first need to add
[celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr):

```bash
dnf copr enable celenity/copr && dnf makecache

# RPM:
dnf install phoenix

# RPM (System Flatpak):
dnf install phoenix-flatpak
```

### Gentoo Linux

> [!WARNING]
>
> These overlays are maintained by the community. For issues with the ebuilds,
> report to the respective overlay repositories.

```bash
eselect repository add urug git https://codeberg.org/koru/urug
emerge --sync urug
emerge --ask firefox-phoenix
```

Also see: <https://codeberg.org/koru/urug>.

### macOS: Homebrew

> [!IMPORTANT]
>
> ⚠️ **Before proceeding, you must have [Homebrew](https://brew.sh) installed.**

```zsh
/bin/zsh -c "$(curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --fail-early --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-xattr --parallel --post301 --post302 --post303 --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer '' --remove-on-error --retry 5 --retry-all-errors --retry-connrefused --show-error --tlsv1.2 --trace-time --user-agent '' --verbose --location https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/scripts/osx_install.sh)"
```

### NixOS

NixOS is supported for
[flake-based configurations](https://wiki.nixos.org/wiki/Flakes#Using_nix_flakes_with_NixOS):

1. Add the Phoenix repository to your flake inputs.
2. Add `phoenix` as one of the arguments to your output function.
3. Add the Phoenix NixOS Module to your configuration.

```nix
{
  inputs = {
    # Note that this assumes you have a flake-input called nixpkgs, which is
    # often the case. If you've named it something else, you'll need to change
    # the `nixpkgs` below.
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
        # This is the important part, add this line to your module list!
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
>
> This is NOT recommended for most users.

By default, Phoenix is installed and updated via your operating system's package
manager. This allows for fast, easy updates & fixes as needed, right with the
rest of your system!

However, if this is not desirable for you and your situation, or you would
simply like to use Phoenix on an unsupported operating system, you can manually
install Phoenix with the following steps:

### Manual: Linux

By default, Phoenix is installed and updated via your operating system's package
manager.

> [!IMPORTANT]
>
> Flatpak Firefox is sandboxed and cannot read `/etc/firefox/`. The
> `/etc/firefox/` steps below do **not** work for Flatpak.

#### Linux and Snap

**1:** Download the archive for your desired Phoenix release:

Replace `{PHOENIX_VERSION}` with the version you'd like to download. The latest
version is always at the top of
[the `Releases` page](https://codeberg.org/celenity/Phoenix/releases) or run:

```bash
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --fail-early --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-xattr --parallel --post301 --post302 --post303 --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer '' --remove-on-error --retry 5 --retry-all-errors --retry-connrefused --show-error --tlsv1.2 --trace-time --user-agent '' --verbose --remote-name --location https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/linux/phoenix-{PHOENIX_VERSION}-linux.tar.xz
```

**2:** Extract the archive:

```bash
cd ~/Downloads # or wherever you downloaded the archive
mkdir -p phoenix && tar -xvf phoenix-{PHOENIX_VERSION}-linux.tar.xz -C phoenix
```

**3:** Create the `/etc/firefox` directory tree.

```bash
sudo mkdir -p /etc/firefox/defaults/pref /etc/firefox/policies && sudo chmod 655 /etc/firefox /etc/firefox/defaults/pref /etc/firefox/policies
```

**4:** Copy `phoenix.cfg` into `/etc/firefox/`.

> [!NOTE]
>
> If you previously installed `phoenix.cfg` somewhere else (e.g. Firefox's
> installation directory), **remove it** to avoid conflicts.

```bash
sudo cp phoenix/phoenix.cfg /etc/firefox/phoenix.cfg
```

**5:** Copy `phoenix.js` into `/etc/firefox/defaults/pref/`.

> [!NOTE]
>
> If `phoenix-desktop.js` exists in this directory, **remove it** to avoid
> conflicts.

```bash
sudo cp phoenix/defaults/pref/phoenix.js /etc/firefox/defaults/pref/phoenix.js
```

**6:** Copy `policies.json` into `/etc/firefox/policies/`.

```bash
sudo cp phoenix/policies/policies.json /etc/firefox/policies/policies.json
```

#### Flatpak

**1:** Determine your extension root.

For a **system** Flatpak install:

```bash
EXT_ROOT="/var/lib/flatpak/extension/org.mozilla.firefox.systemconfig/$(flatpak --default-arch)/stable"
```

For a **user** Flatpak install (`flatpak install --user`):

```bash
EXT_ROOT="$HOME/.local/share/flatpak/extension/org.mozilla.firefox.systemconfig/$(flatpak --default-arch)/stable"
```

**2:** Download the Flatpak-specific Phoenix archive.

The Flatpak build ships `phoenix-desktop.js` instead of `phoenix.js`, also
per-config `user.js` files under `flatpak/`. Replace `{PHOENIX_VERSION}` with
your desired version:

```bash
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --fail-early --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-xattr --parallel --post301 --post302 --post303 --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer '' --remove-on-error --retry 5 --retry-all-errors --retry-connrefused --show-error --tlsv1.2 --trace-time --user-agent '' --verbose --remote-name --location https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/linux-flatpak/phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
```

**3:** Extract the archive:

```bash
mkdir -p phoenix-flatpak && tar -xvf phoenix-{PHOENIX_VERSION}-flatpak.zip -C phoenix-flatpak
```

**4:** Create the extension directory tree.

```bash
sudo mkdir -p "$EXT_ROOT/defaults/pref" "$EXT_ROOT/policies"
```

> [!NOTE]
>
> For a **user** Flatpak, drop `sudo`.

**5:** Install the core Phoenix files into the extension root.

```bash
sudo install -Dm644 phoenix-flatpak/phoenix.cfg "$EXT_ROOT/phoenix.cfg"
sudo install -Dm644 phoenix-flatpak/defaults/pref/phoenix-desktop.js "$EXT_ROOT/defaults/pref/phoenix-desktop.js"
sudo install -Dm644 phoenix-flatpak/policies/policies.json "$EXT_ROOT/policies/policies.json"
```

### Manual: macOS

**1:** Download the archive for your desired Phoenix release:

This can be found at the link below _(replacing `{PHOENIX_VERSION}` with the
version of Phoenix you'd like to download)_. For reference, the latest version
of Phoenix can always be found at the top of
[the `Releases` page](https://codeberg.org/celenity/Phoenix/releases):

```zsh
https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/osx/phoenix-{PHOENIX_VERSION}-osx.tar.xz
```

You can navigate to the link above and download the archive directly from your
web browser, or you can run the following command in your terminal:

```zsh
curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --fail-early --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-xattr --parallel --post301 --post302 --post303 --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer '' --remove-on-error --retry 5 --retry-all-errors --retry-connrefused --show-error --tlsv1.2 --trace-time --user-agent '' --verbose --remote-name --location https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/osx/phoenix-{PHOENIX_VERSION}-osx.tar.xz
```

**2:** Extract your downloaded archive:

First, create the directory where you'd like to extract Phoenix:

```zsh
mkdir -p phoenix
```

Now, extract the downloaded archive:

_(Replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to
download, and `/path/to` with the path to your downloaded archive)_

```zsh
tar xJf /path/to/phoenix-{PHOENIX_VERSION}-osx.tar.xz -C phoenix
```

**3:** Locate your Firefox installation directory. This will vary depending on
your platform. An easy way to find it is by navigating to `about:support` and
checking the directory next to `Application Binary`. For example: If I see
`/Users/${USER}/Applications/Firefox.app/Contents/MacOS/firefox` listed next to
`Application Binary`, my installation directory would be:
**`/Users/${USER}/Applications/Firefox.app`**.

> [!CAUTION]
>
> **Your directory will probably be different, and you should replace this
> directory on the following steps with your actual installation directory.**

**4:** Copy `macos/phoenix.cfg` to the **`Resources`** folder within your
installation directory. You can either drag and drop it manually, or run the
following command: _assuming `/Users/${USER}/Applications/Firefox.app` is your
installation directory_

```zsh
sudo cp phoenix/macos/phoenix.cfg /Users/${USER}/Applications/Firefox.app/Resources/phoenix.cfg
```

**5:** If it does not already exist, inside the `Resources` directory, create a
new folder named `defaults`, and inside this new `defaults` folder, create
another folder titled `pref`. You can do this manually through your file
explorer, or you can run the following command: _assuming
`/Users/${USER}/Applications/Firefox.app` is your installation directory_

```zsh
sudo mkdir -p /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref
```

You'll also want to ensure that the folder you created has proper permissions:

```zsh
sudo chmod 744 /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref
```

**6:** Copy `defaults/pref/phoenix.js` to the `pref` folder that you just
created. You can run the following command: _Assuming your installation
directory is `/Users/${USER}/Applications/Firefox.app`_

```zsh
sudo cp phoenix/defaults/pref/phoenix.js /Users/${USER}/Applications/Firefox.app/Resources/defaults/pref/phoenix.js
```

**7:** Finally, copy `macos/org.mozilla.firefox.plist` to
`/Library/Preferences`, and **reboot** your device once finished:

```zsh
sudo cp phoenix/macos/org.mozilla.firefox.plist /Library/Preferences/org.mozilla.firefox.plist
```

### Manual: Windows

**1:** Download the archive for your desired Phoenix release:

This can be found at the link below _(replacing `{PHOENIX_VERSION}` with the
version of Phoenix you'd like to download)_. For reference, the latest version
of Phoenix can always be found at the top of
[the `Releases` page](https://codeberg.org/celenity/Phoenix/releases):

```powershell
https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/windows/phoenix-{PHOENIX_VERSION}-windows.zip
```

You can navigate to the link above and download the archive directly from your
web browser, or you can run the following command in your terminal:

```powershell
Invoke-WebRequest -UserAgent '' -Uri 'https://releases.celenity.dev/phoenix/releases/{PHOENIX_VERSION}/windows/phoenix-{PHOENIX_VERSION}-windows.zip' -OutFile 'phoenix-{PHOENIX_VERSION}-windows.zip'
```

**2:** Extract your downloaded archive:

First, create the directory where you'd like to extract Phoenix:

```powershell
New-Item -ItemType 'Directory' -Name 'phoenix'
```

Now, extract the downloaded archive:

_(Replacing `{PHOENIX_VERSION}` with the version of Phoenix you'd like to
download, and `\Path\To` with the path to your downloaded archive)_

```powershell
Expand-Archive -Path '\Path\To\phoenix-{PHOENIX_VERSION}-windows.zip' -DestinationPath 'phoenix'
```

**4:** Locate your Firefox installation directory. This will vary depending on
your platform. An easy way to find it is by navigating to `about:support` and
checking the directory next to `Application Binary`.

> [!CAUTION]
>
> **Your directory will probably be different, and you should replace this
> directory on the following steps with your actual installation directory.**

**5:** Copy `phoenix.cfg` to the **root** of your installation directory. You
can either drag and drop it manually, or run the following command:

```powershell
Copy-Item -Path 'phoenix\phoenix.cfg' -Destination 'C:\Program Files\Mozilla Firefox\'
```

**6:** If it does not already exist, in the **root** of your installation
directory, create a folder named `defaults`, and inside this new `defaults`
folder, create another folder titled `pref`. You can do this manually through
your file explorer, or you can run the following command:

```powershell
New-Item -Path 'C:\Program Files\Mozilla Firefox\' -ItemType 'Directory' -Name 'defaults\pref'
```

**7:** Copy `defaults\pref\phoenix.js` to the `pref` folder that you just
created. You can run the following command:

```powershell
Copy-Item -Path 'phoenix\defaults\pref\phoenix.js' -Destination 'C:\Program Files\Mozilla Firefox\defaults\pref\'
```

**8:** In the **root** of your installation directory, create a folder named
`distribution`. You can do this manually through your file explorer, or you can
run the following command:

```powershell
New-Item -Path 'C:\Program Files\Mozilla Firefox\' -ItemType 'Directory' -Name 'distribution'
```

**9:** Finally, copy `distribution\policies.json` to the `distribution` folder
that you just created. You can run the following command:

```powershell
Copy-Item -Path 'phoenix\distribution\policies.json' -Destination 'C:\Program Files\Mozilla Firefox\distribution\'
```
