# 👋Uninstall

**<details><summary>Arch</summary>**

> [!NOTE]
> You can use **`paru`** instead of **`yay`** with the same options.

Firefox *(Standard)*:

```sh
yay -Rcns phoenix-arch
```

Firefox *(System Flatpak)*:

```sh
yay -Rcns phoenix-flatpak
```

</details>

**<details><summary>Debian/Ubuntu & derivatives</summary>**

Firefox *(DEB)*:

```sh
sudo apt remove phoenix
```

Firefox *(System Flatpak)*:

```sh
sudo apt remove phoenix-flatpak
```

You can also remove [celenity's OBS repo](https://build.opensuse.org/project/show/home:celenity) if desired:

```sh
sudo rm /etc/apt/sources.list.d/home:celenity.list
sudo rm /etc/apt/trusted.gpg.d/home_celenity.gpg
sudo apt update
```

</details>

**<details><summary>Fedora</summary>**

Firefox *(Standard)*:

```sh
sudo dnf remove phoenix
```

Firefox *(System Flatpak)*:

```sh
sudo dnf remove install phoenix-flatpak
```

You can also remove [celenity's COPR repo](https://copr.fedorainfracloud.org/coprs/celenity/copr/) if desired:

```sh
sudo dnf copr remove celenity/copr
sudo dnf makecache
```

</details>

**<details><summary>macOS</summary>**

Run the following uninstall script in your terminal of choice:

```sh
/bin/zsh -c "$(curl -q --disable --no-netrc -j -e "" -i -A "" -S --clobber --create-dirs --delegation "none" --disallow-username-in-url --doh-cert-status --ftp-create-dirs --ftp-ssl-control --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-proxy-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ntlm --no-proxy-ssl-allow-beast --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl --no-ssl-allow-beast --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer "" --remove-on-error --show-error --show-headers --ssl-reqd --trace-time --user-agent "" --verbose -sSL https://gitlab.com/celenityy/Phoenix/-/raw/pages/uninstaller_scripts/macos_uninstall.sh)"
```

</details>

**<details><summary>NixOS</summary>**

**?**

</details>

Please [leave us feedback](https://phoenix.celenity.dev/issues) on the way out, so we can improve for the future!
