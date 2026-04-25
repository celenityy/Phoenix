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
  - [Linux](#linux)
    - [Apple Maps](#apple-maps)
    - [Discord](#discord)
    - [Element](#element)
    - [Google Maps](#google-maps)
    - [Twitter](#twitter)
    - [YouTube](#youtube)
  - [macOS](#macos)
    - [Apple Maps](#apple-maps)
    - [Discord](#discord)
    - [Element](#element)
    - [Google Maps](#google-maps)
    - [Twitter](#twitter)
    - [YouTube](#youtube)

## Linux

### Apple Maps

#### Default

```sh
# System
/etc/firefox/phoenix/userjs/apple-maps/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/apple-maps/user.js
```

#### Firefox-UI-Fix

```sh
# System
/etc/firefox/phoenix/userjs/ui-fix/apple-maps/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/apple-maps/user.js
```

### Discord

#### Default

```sh
# System
/etc/firefox/phoenix/userjs/discord/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/discord/user.js
```

#### Firefox-UI-Fix

```sh
# System
/etc/firefox/phoenix/userjs/ui-fix/discord/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/discord/user.js
```

### Element

#### Default

```sh
# System
/etc/firefox/phoenix/userjs/element/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/element/user.js
```

#### Firefox-UI-Fix

```sh
# System
/etc/firefox/phoenix/userjs/ui-fix/element/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/element/user.js
```

### Google Maps

#### Default

```sh
# System
/etc/firefox/phoenix/userjs/google-maps/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/google-maps/user.js
```

#### Firefox-UI-Fix

```sh
# System
/etc/firefox/phoenix/userjs/ui-fix/google-maps/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/google-maps/user.js
```

### Twitter

#### Default

```sh
# System
/etc/firefox/phoenix/userjs/twitter/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/twitter/user.js
```

#### Firefox-UI-Fix

```sh
# System
/etc/firefox/phoenix/userjs/ui-fix/twitter/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/twitter/user.js
```

### YouTube

#### Default

```sh
# System
/etc/firefox/phoenix/userjs/youtube/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/youtube/user.js
```

#### Firefox-UI-Fix

```sh
# System
/etc/firefox/phoenix/userjs/ui-fix/youtube/user.js

# Flatpak
/var/lib/flatpak/app/org.mozilla.firefox/current/active/files/etc/firefox/phoenix/userjs/ui-fix/youtube/user.js
```

## macOS

### Apple Maps

#### Default

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/apple-maps/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/apple-maps/user.js
```

#### Firefox-UI-Fix

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/apple-maps/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/ui-fix/apple-maps/user.js
```

### Discord

#### Default

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/discord/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/discord/user.js
```

#### Firefox-UI-Fix

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/discord/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/ui-fix/discord/user.js
```

### Element

#### Default

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/element/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/element/user.js
```

#### Firefox-UI-Fix

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/element/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/ui-fix/element/user.js
```

### Google Maps

#### Default

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/google-maps/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/google-maps/user.js
```

#### Firefox-UI-Fix

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/google-maps/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/ui-fix/google-maps/user.js
```

### Twitter

#### Default

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/twitter/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/twitter/user.js
```

#### Firefox-UI-Fix

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/twitter/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/ui-fix/twitter/user.js
```

### YouTube

#### Default

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/youtube/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/youtube/user.js
```

#### Firefox-UI-Fix

```sh
# Apple Silicon
/opt/homebrew/opt/phoenix-osx/userjs/ui-fix/youtube/user.js

# Intel
/usr/local/opt/phoenix-osx/userjs/ui-fix/youtube/user.js
```
