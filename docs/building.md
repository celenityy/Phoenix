# 🔨 Building

## Dependencies

To build Phoenix, you'll first want to ensure you've installed the necessary
dependencies for your system:

### Linux

#### Fedora

```bash
dnf install bash curl jq
```

#### Gentoo

```bash
emerge -av app-shells/bash net-misc/curl app-misc/jq
```

### macOS

**NOTE**: [Homebrew](https://brew.sh) **must** be installed
_(if is not already installed)_ before following the steps below.

```zsh
/usr/bin/xcode-select --install
brew install gawk gnu-sed gnu-tar jq
```

### Windows

```powershell
?
```

## Build

Now, you'll want to get the Phoenix repository.
With `git`, you can use:

```sh
git clone --depth=1 git@codeberg.org:celenity/Phoenix.git && cd Phoenix
```

**From the root of the repository**, download Phoenix's sources:

```sh
bash -x scripts/get_sources.sh
```

Finally, **from the root of the repository**, build Phoenix!:

```sh
bash -x scripts/build.sh
```

