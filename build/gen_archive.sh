#!/usr/bin/env bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

rm -rf archives/*

cd "$phoenix_linux_dir"

echo_green_text "Creating archives/phoenix-linux.zip..."

zip -r -FS "$phoenix_dir/archives/phoenix-linux.zip" *

cd "$phoenix_linux_flatpak_dir"

echo_green_text "Creating archives/phoenix-flatpak.zip..."

zip -r -FS "$phoenix_dir/archives/phoenix-flatpak.zip" *

cd "$phoenix_osx_dir"

echo_green_text "Creating archives/phoenix-osx.zip..."

zip -r -FS "$phoenix_dir/archives/phoenix-osx.zip" * -x 'Library/*'

cd "$phoenix_osx_intel_dir"

echo_green_text "Creating archives/phoenix-osx-intel.zip..."

zip -r -FS "$phoenix_dir/archives/phoenix-osx-intel.zip" * -x 'Library/*'

cd "$phoenix_windows_dir"

echo_green_text "Creating archives/phoenix-windows.zip..."

zip -r -FS "$phoenix_dir/archives/phoenix-windows.zip" *

cd "$phoenix_dir"
