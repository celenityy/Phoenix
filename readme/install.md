# 🚀Install

> [!IMPORTANT]
> ⚠️ After Phoenix is installed, you **MUST** restart Firefox after its first run with Phoenix installed. **This ensures all of Phoenix's changes are applied...**

Phoenix currently provides official support for:

* **Android**
* **Arch Linux**
* **Debian** *(& derivatives...)*
* **Fedora Linux** *(39-41)*
* **NixOS**
* **macOS**
* **Ubuntu** *(& derivatives...)*

Other platforms have unfortunately proven difficult to support, though progress **is** being made. Contributions are always welcome and appreciated.

> [!NOTE]
> ⚠️ **Flatpak *(User)* & Snap packages of Firefox are currently not supported.**

> [!IMPORTANT]
> **Android users are recommended to install [IronFox](https://gitlab.com/ironfox-oss/IronFox) *(Recommended)*, which uses Phoenix for its configs. Android users can also manually install Phoenix for any Firefox-based browser on Android via the directions [here](https://phoenix.celenity.dev/android).**

**<details><summary>Arch</summary>**

> [!NOTE]
> You can use **`paru`** instead of **`yay`** with the same options.

Firefox *(Pacman)*:

```sh
yay -S phoenix-arch
```

Firefox *(System Flatpak)*:

```sh
yay -S phoenix-flatpak
```

</details>

**<details><summary>Debian/Ubuntu & derivatives</summary>**

 Before installing Phoenix, you'll first need to add [celenity's OBS repo](https://build.opensuse.org/project/show/home:celenity):

> [!NOTE]
> You may see a warning, such as the following, when updating your `apt` cache.
>
> ```sh
> Warning: https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/InRelease: Policy will reject signature within a year, see --audit for details
> ```
>
> This is because `apt` will not support V3 GPG keys after `2026-02-01`, and currently the OBS uses a V3 GPG key. For now, there shouldn't be any issues.

 ```sh
 echo 'deb https://download.opensuse.org/repositories/home:/celenity/Debian_Unstable/ /' | sudo tee /etc/apt/sources.list.d/home:celenity.list
 wget -O- https://download.opensuse.org/repositories/home:celenity/Debian_Unstable/Release.key 2>/dev/null | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_celenity.gpg > /dev/null
 sudo apt update
 ```

Firefox *(DEB)*:

```sh
sudo apt install phoenix
```

Firefox *(System Flatpak)*:

```sh
sudo apt install phoenix-flatpak
```

</details>

**<details><summary>Fedora</summary>**

 Before installing Phoenix, you'll first need to add [celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr/):

 ```sh
 sudo dnf copr enable celenity/copr
 sudo dnf makecache
 ```

Firefox *(RPM)*:

```sh
sudo dnf install phoenix
```

Firefox *(System Flatpak)*:

```sh
sudo dnf install phoenix-flatpak
```

</details>

**<details><summary>macOS</summary>**

> [!IMPORTANT]
> ⚠️ **Before proceeding, you must have [Homebrew](https://brew.sh/) installed.**

Run the following installation script in your terminal of choice:

```sh
/bin/zsh -c "$(curl --cert-status --doh-cert-status --no-insecure --no-proxy-insecure --no-sessionid --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --proto -all,https --proto-default https --proto-redir -all,https --show-error -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/installer_scripts/macos_install.sh)"
```

</details>

**<details><summary>NixOS</summary>**

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
      url = "git+https://gitlab.com/celenityy/Phoenix";
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

</details>

## **If you would like to use Phoenix on any other unsupported platform, see [📛Manual Installation](manual_installation.md).**
