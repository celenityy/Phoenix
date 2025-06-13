#!/usr/bin/env bash

# Version of Phoenix you'd like to build
export phoenix_version=2025.06.12.1

# Where `Phoenix` (this repo) is located
export phoenix_dir=$(dirname $(dirname "$(realpath "$0")"))

# Where the `android` directory is located
export phoenix_android_dir="$phoenix_dir/android"

# Where the `linux` directory is located
export phoenix_linux_dir="$phoenix_dir/linux"

# Where the `macos` directory is located
export phoenix_osx_dir="$phoenix_dir/macos"

# Where the `windows` directory is located
export phoenix_windows_dir="$phoenix_dir/windows"
