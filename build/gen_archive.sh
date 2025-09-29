#!/usr/bin/env bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

source "$phoenix_dir/build/env.sh"

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    rm -f archives/phoenix-linux.zip
else
	rm -rf archives/*
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/sbin/dot_clean -mv "$phoenix_linux_dir"
fi

cd "$phoenix_linux_dir"
echo_green_text "Creating archives/phoenix-linux.zip..."
zip -r -FS "$phoenix_dir/archives/phoenix-linux.zip" *

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Flatpak..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
	if [[ "$OSTYPE" == "darwin"* ]]; then
    	/usr/sbin/dot_clean -mv "$phoenix_linux_flatpak_dir"
	fi
    cd "$phoenix_linux_flatpak_dir"
	echo_green_text "Creating archives/phoenix-flatpak.zip..."
	zip -r -FS "$phoenix_dir/archives/phoenix-flatpak.zip" *
fi

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
	if [[ "$OSTYPE" == "darwin"* ]]; then
    	/usr/sbin/dot_clean -mv "$phoenix_osx_dir"
	fi
    cd "$phoenix_osx_dir"
	echo_green_text "Creating archives/phoenix-osx.zip..."
	zip -r -FS "$phoenix_dir/archives/phoenix-osx.zip" * -x 'Library/*'
fi

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping macOS Intel..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
	if [[ "$OSTYPE" == "darwin"* ]]; then
    	/usr/sbin/dot_clean -mv "$phoenix_osx_intel_dir"
	fi
    cd "$phoenix_osx_intel_dir"
	echo_green_text "Creating archives/phoenix-osx-intel.zip..."
	zip -r -FS "$phoenix_dir/archives/phoenix-osx-intel.zip" * -x 'Library/*'
fi

if [[ -n "$PHOENIX_LINUX_ONLY" ]]; then
    echo "\$PHOENIX_LINUX_ONLY is set! Skipping Windows..."
fi

if [[ -z "$PHOENIX_LINUX_ONLY" ]]; then
	if [[ "$OSTYPE" == "darwin"* ]]; then
    	/usr/sbin/dot_clean -mv "$phoenix_windows_dir"
	fi
    cd "$phoenix_windows_dir"
	echo_green_text "Creating archives/phoenix-windows.zip..."
	zip -r -FS "$phoenix_dir/archives/phoenix-windows.zip" *
fi

cd "$phoenix_dir"
