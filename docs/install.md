# 🚀 Installation

> [!IMPORTANT]
> ⚠️ After Phoenix is installed, you **MUST** restart Firefox after its first
> run with Phoenix installed. **This ensures all of Phoenix's changes are applied...**

## Support

| Platform | Derivatives | Stable | ESR | Forks / Other                     | Support Status                                            |
| -------- | ----------- | ------ | --- | --------------------------------- | --------------------------------------------------------- |
| Android  | Yes         | ✅     | ❌  | [IronFox](https://ironfoxoss.org) | Official                                                  |
| Arch     | Partial     | ✅     | ❌  | -                                 | Official + Community                                      |
| Debian   | Yes         | ✅     | ✅  | -                                 | Official                                                  |
| Fedora   | Yes         | ✅     | ❌  | -                                 | Official                                                  |
| Flatpak  | -           | ❌     | ❌  | -                                 | [Broken](https://codeberg.org/celenity/Phoenix/issues/5)  |
| Gentoo   | Yes         | ✅     | ✅  | -                                 | Community                                                 |
| macOS    | -           | ✅     | ❌  | -                                 | Official                                                  |
| NixOS    | Yes         | ✅     | ❌  | -                                 | Official + Community                                      |
| Snap     | -           | ❌     | ❌  | -                                 | [Broken](https://codeberg.org/celenity/Phoenix/issues/5)  |
| Ubuntu   | Yes         | ✅     | ✅  | -                                 | Official                                                  |
| Windows  | -           | ✅     | ❌  | Zen Browser                       | [Partial](https://codeberg.org/celenity/Phoenix/issues/3) |

Also see: [Repology](https://repology.org/project/phoenix-firefox/versions).

1. _Flatpak targets the `org.mozilla.firefox` package from the [Flathub remote](https://flathub.org/en/about)._
2. _Gentoo GNU/Linux supports stable and ESR builds via both binary and source compilation._

Other platforms have unfortunately proven difficult to support, though progress
is being made. Contributions are always welcome and appreciated.

## Table of Contents

- [Arch Linux](#arch-linux)
- [Debian/Ubuntu-based](#debianubuntu-and-derivatives)
- [Fedora-based](#fedora-linux)
- [Gentoo Linux](#gentoo-linux)
- [macOS: Homebrew](#macos-homebrew)
- [NixOS](#nixos)
- [Windows](#windows)

> [!NOTE]
> ⚠️ **Flatpak _(User)_ & Snap packages of Firefox are currently not supported.**

> [!IMPORTANT]
> **Android users are recommended to install
> [IronFox](https://gitlab.com/ironfox-oss/IronFox) _(Recommended)_, which uses
> Phoenix for its configs. Android users can also manually install Phoenix for
> any Firefox-based browser on Android via [directions](https://phoenix.celenity.dev/android).**

### Arch Linux

```bash
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
> ```bash
> Warning: https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/InRelease: Policy will reject signature within a year, see --audit for details
> ```
>
> This is because `apt` will not support V3 GPG keys after `2026-02-01`, and
> currently the OBS uses a V3 GPG key. For now, there shouldn't be any issues.

```bash
echo 'deb https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/ /' | sudo tee /etc/apt/sources.list.d/home:celenity.list
wget -O- https://download.opensuse.org/repositories/home:celenity/Debian_Unstable/Release.key 2>/dev/null | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null
sudo apt update
```

```bash
# APT:
sudo apt install phoenix

# APT (System Flatpak):
sudo apt install phoenix-flatpak
```

### Fedora Linux

Before installing Phoenix, you'll first need to add [celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr):

```bash
sudo dnf copr enable celenity/copr && sudo dnf makecache

# RPM:
sudo dnf install phoenix

# RPM (System Flatpak):
sudo dnf install phoenix-flatpak
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
> ⚠️ **Before proceeding, you must have [Homebrew](https://brew.sh) installed.**

```zsh
/bin/zsh -c "$(curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --fail-early --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-auto-client-cert --no-sessionid --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-xattr --parallel --post301 --post302 --post303 --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer '' --remove-on-error --retry 5 --retry-all-errors --retry-connrefused --show-error --tlsv1.2 --trace-time --user-agent '' --verbose --location https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/scripts/osx_install.sh)"
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

### Windows

> [!IMPORTANT]
> **Windows users must follow the steps in the [Manual Installation](./install-manual#windows) wiki page.**

## End

Congratulations, you're done!
Enjoy Phoenix, and be sure to keep up with updates!
