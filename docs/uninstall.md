# 👋 Uninstall

## Arch Linux

```sh
# You can use `paru` instead of `yay` with the same options.

# Pacman:
yay -Rcns phoenix-arch

# System Flatpak:
yay -Rcns phoenix-flatpak
```

## Debian + Ubuntu

```sh
# APT:
sudo apt remove phoenix

# System Flatpak:
sudo apt remove phoenix-flatpak

# OBS:
sudo rm /etc/apt/sources.list.d/home:celenity.list
sudo rm /etc/apt/trusted.gpg.d/home_celenity.gpg
sudo apt update
```

## Fedora Linux

```sh
# RPM:
sudo dnf remove phoenix

# System Flaptak:
sudo dnf remove install phoenix-flatpak

# COPR:
sudo dnf copr remove celenity/copr
sudo dnf makecache
```

## macOS

```sh
/bin/zsh -c "$(curl --disable --no-netrc --clobber --create-dirs --delegation none --disallow-username-in-url --doh-cert-status --fail --fail-early --http3 --junk-session-cookies --no-basic --no-ca-native --no-digest --no-doh-insecure --no-http0.9 --no-insecure --no-negotiate --no-ntlm --no-proxy-basic --no-proxy-ca-native --no-proxy-digest --no-proxy-insecure --no-proxy-ssl-auto-client-cert --no-sessionid --no-skip-existing --no-ssl-auto-client-cert --no-ssl-no-revoke --no-ssl-revoke-best-effort --no-tls-earlydata --no-xattr --parallel --post301 --post302 --post303 --progress-meter --proto -all,https --proto-default https --proto-redir -all,https --referer '' --remove-on-error --retry 5 --retry-all-errors --retry-connrefused --show-error --tlsv1.2 --trace-time --user-agent '' --verbose --location https://gitlab.com/celenityy/Phoenix/-/raw/pages/osx/scripts/osx_uninstall.sh)"
```

## NixOS

```nix
?
```

## Notes

Please [leave us feedback](https://phoenix.celenity.dev/issues) on the way out,
so we can improve for the future!
