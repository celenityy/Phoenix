# 💡 Specialized Configs

It should also be noted that Phoenix contains specialized configurations for
**Apple Maps**, **Discord**, **Element**, **Google Maps**, **Twitter**, and
**YouTube**. These configs are designed to be used in their own, separate
Firefox profile, and provide means to safely and easily use these services, like
you would any other app on your device.

> [!IMPORTANT]
> ⚠️ **Discord**, **Google Maps**, **Twitter**, and **YouTube** are
> explicitly **not** recommended for use, due to their privacy-invasive nature.
> These configs are simply meant to provide **harm reduction** for users who
> need to use these services for whatever reason,
> **but it is still best to avoid them entirely if possible.**

The installation of these configs is the same as `Extended`, with the only
exception being the location of the `user.js` file.
**You can find the location of these user.js files at the following locations:**

## Table of Contents

- [Specialized Configs](#-specialized-configs)
  - [Table of Contents](#table-of-contents)
  - [Notes](#notes)
  - [Linux](#linux)
    - [Linux: Apple Maps](#linux-apple-maps)
    - [Linux: Discord](#linux-discord)
    - [Linux: Element](#linux-element)
    - [Linux: Google Maps](#linux-google-maps)
    - [Linux: Twitter](#linux-twitter)
    - [Linux: YouTube](#linux-youtube)
  - [macOS](#macos)
    - [macOS: Apple Maps](#macos-apple-maps)
    - [macOS: Discord](#macos-discord)
    - [macOS: Element](#macos-element)
    - [macOS: Google Maps](#macos-google-maps)
    - [macOS: Twitter](#macos-twitter)
    - [macOS: YouTube](#macos-youtube)

## Notes

> [!NOTE]
> Linux:
> System - `/etc/*`
> Flatpak - `/var/*`
>
> macOS:
> Silicon - `/opt/*`
> Intel - `/usr/*`

## Linux

### Linux: Apple Maps

```bash
# Default
/etc/firefox/phoenix/userjs/apple-maps/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/apple-maps/user.js

# Firefox-UI-Fix
/etc/firefox/phoenix/userjs/ui-fix/apple-maps/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/apple-maps/user.js
```

### Linux: Discord

```bash
# Default
/etc/firefox/phoenix/userjs/discord/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/discord/user.js

# Firefox-UI-Fix
/etc/firefox/phoenix/userjs/ui-fix/discord/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/discord/user.js
```

### Linux: Element

```bash
# Default
/etc/firefox/phoenix/userjs/element/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/element/user.js

# Firefox-UI-Fix
/etc/firefox/phoenix/userjs/ui-fix/element/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/element/user.js
```

### Linux: Google Maps

```bash
# Default
/etc/firefox/phoenix/userjs/google-maps/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/google-maps/user.js

# Firefox-UI-Fix
/etc/firefox/phoenix/userjs/ui-fix/google-maps/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/google-maps/user.js
```

### Linux: Twitter

```bash
# Default
/etc/firefox/phoenix/userjs/twitter/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/twitter/user.js

# Firefox-UI-Fix
/etc/firefox/phoenix/userjs/ui-fix/twitter/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/twitter/user.js
```

### Linux: YouTube

```bash
# Default
/etc/firefox/phoenix/userjs/youtube/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/youtube/user.js

# Firefox-UI-Fix
/etc/firefox/phoenix/userjs/ui-fix/youtube/user.js
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/youtube/user.js
```

## macOS

### macOS: Apple Maps

```zsh
# Default
/opt/homebrew/opt/phoenix-osx/userjs/apple-maps/user.js
/usr/local/opt/phoenix-osx/userjs/apple-maps/user.js

# Firefox-UI-Fix
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/apple-maps/user.js
/usr/local/opt/phoenix-osx/userjs/ui-fix/apple-maps/user.js
```

### macOS: Discord

```zsh
# Default
/opt/homebrew/opt/phoenix-osx/userjs/discord/user.js
/usr/local/opt/phoenix-osx/userjs/discord/user.js

# Firefox-UI-Fix
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/discord/user.js
/usr/local/opt/phoenix-osx/userjs/ui-fix/discord/user.js
```

### macOS: Element

```zsh
# Default
/opt/homebrew/opt/phoenix-osx/userjs/element/user.js
/usr/local/opt/phoenix-osx/userjs/element/user.js

# Firefox-UI-Fix
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/element/user.js
/usr/local/opt/phoenix-osx/userjs/ui-fix/element/user.js
```

### macOS: Google Maps

```zsh
# Default
/opt/homebrew/opt/phoenix-osx/userjs/google-maps/user.js
/usr/local/opt/phoenix-osx/userjs/google-maps/user.js

# Firefox-UI-Fix
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/google-maps/user.js
/usr/local/opt/phoenix-osx/userjs/ui-fix/google-maps/user.js
```

### macOS: Twitter

```zsh
# Default
/opt/homebrew/opt/phoenix-osx/userjs/twitter/user.js
/usr/local/opt/phoenix-osx/userjs/twitter/user.js

# Firefox-UI-Fix
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/twitter/user.js
/usr/local/opt/phoenix-osx/userjs/ui-fix/twitter/user.js
```

### macOS: YouTube

```zsh
# Default
/opt/homebrew/opt/phoenix-osx/userjs/youtube/user.js
/usr/local/opt/phoenix-osx/userjs/youtube/user.js

# Firefox-UI-Fix
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/youtube/user.js
/usr/local/opt/phoenix-osx/userjs/ui-fix/youtube/user.js
```
