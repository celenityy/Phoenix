# Build Phoenix

## Dependencies

To build Phoenix, you'll first want to ensure you've installed the necessary dependencies for your system:

### Fedora

```sh
dnf install bash curl jq
```

### Gentoo

```sh
emerge -av app-shells/bash app-misc/jq
```

### macOS

**NOTE**: [Homebrew](https://brew.sh/) **must** be installed *(if is not already installed)* before following the steps below.

```sh
/usr/bin/xcode-select --install
brew install gawk gnu-sed gnu-tar jq
```

## Get Phoenix

Now, you'll want to get the Phoenix repository.

With `git`, you can use:

```sh
git clone --depth=1 git@codeberg.org:celenity/Phoenix.git Phoenix
```

**For the following steps, ensure you have navigated to the root of the repository**:

```sh
cd Phoenix
```

## Sources

**From the root of the repository**, download Phoenix's sources:

```sh
bash -x scripts/get_sources.sh
```

## Build

Finally, **from the root of the repository**, build Phoenix!:

```sh
bash -x scripts/build.sh
```
