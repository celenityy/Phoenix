#!/usr/bin/env bash

# Version of Phoenix you'd like to build
export phoenix_version=2025.11.07.1

# Where `Phoenix` (this repo) is located
export phoenix_dir=$(dirname $(dirname "$(realpath "$0")"))

# Where the `android` directory is located
export phoenix_android_dir="$phoenix_dir/android"

# Where the `linux` directory is located
export phoenix_linux_dir="$phoenix_dir/linux"

# Where the `linux-flatpak` directory is located
export phoenix_linux_flatpak_dir="$phoenix_dir/linux-flatpak"

# Where the `macos` directory is located
export phoenix_osx_dir="$phoenix_dir/macos"

# Where the `macos-intel` directory is located
export phoenix_osx_intel_dir="$phoenix_dir/macos-intel"

# Where the `windows` directory is located
export phoenix_windows_dir="$phoenix_dir/windows"

# If variables are defined with a custom `env_local.sh`, let's use those
if [[ -f "$phoenix_dir/build/env_local.sh" ]]; then
    source "$phoenix_dir/build/env_local.sh"
fi

# Use GNU Sed on macOS instead of the built-in sed, due to differences in syntax
if [[ "$OSTYPE" == "darwin"* ]]; then
    SED=gsed
else
    SED=sed
fi
