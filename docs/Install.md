# 🚀 Install

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

## Installation

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

### Fedora

Before installing Phoenix, you'll first need to add [celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr):

 ```sh
 sudo dnf copr enable celenity/copr
 sudo dnf makecache

# RPM:
sudo dnf install phoenix

# RPM (System Flatpak):
sudo dnf install phoenix-flatpak
```

### macOS

> [!IMPORTANT]
> ⚠️ **Before proceeding, you must have [Homebrew](https://brew.sh) installed.**

```sh
/bin/zsh -c "$(curl -q --disable --no-netrc -j -e "" -A "" -S --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --ssl-reqd --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/installer_scripts/osx_install.sh)"
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

## Manual

If you would like to use Phoenix on any other unsupported platform,
see [📛 Manual Installation](ManualInstallation.md).
