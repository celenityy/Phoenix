#!/bin/bash

set -euo pipefail

# Functions
echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

error_fn() {
	echo
	echo_red_text -e "\033[31mSomething went wrong! The script failed.\033[0m"
	echo_red_text -e "\033[31mPlease report this (with the output message) to https://phoenix.celenity.dev/issues\033[0m"
	echo
	exit 1
}

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

# Set-up our environment
bash -x $(dirname $0)/env.sh || error_fn
echo
source $(dirname $0)/env.sh || error_fn
echo

rm -rf "${PHOENIX_ARCHIVES}/*" || error_fn
echo

# dot_clean for OS X
PHOENIX_DOT_CLEAN='/usr/sbin/dot_clean -mv'

# zip
PHOENIX_ZIP='zip -r -FS'

if [ "${PHOENIX_LINUX}" == 1 ]; then
    if [[ "${PHOENIX_OS}" == 'osx' ]]; then
        "${PHOENIX_DOT_CLEAN}" "${PHOENIX_LINUX_DIR}" || error_fn
        echo
    fi

    pushd "${PHOENIX_LINUX_DIR}"
    echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-linux.zip..."
    "${PHOENIX_ZIP}" "${PHOENIX_ARCHIVES}/phoenix-linux.zip" * || error_fn
    echo
    popd
fi

if [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
	if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    	"${PHOENIX_DOT_CLEAN}" "${PHOENIX_LINUX_FLATPAK_DIR}" || error_fn
        echo
	fi
    pushd "${PHOENIX_LINUX_FLATPAK_DIR}"
	echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-flatpak.zip..."
	"${PHOENIX_ZIP}" "${PHOENIX_ARCHIVES}/phoenix-flatpak.zip" * || error_fn
    echo
    popd
fi

if [ "${PHOENIX_OSX}" == 1 ]; then
	if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    	"${PHOENIX_DOT_CLEAN}" "${PHOENIX_OSX_DIR}" || error_fn
        echo
	fi
    pushd "${PHOENIX_OSX_DIR}"
	echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-osx.zip..."
	"${PHOENIX_ZIP}" "${PHOENIX_ARCHIVES}/phoenix-osx.zip" * -x 'Library/*' || error_fn
    echo
    popd
fi

if [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
	if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    	"${PHOENIX_DOT_CLEAN}" "${PHOENIX_OSX_INTEL_DIR}" || error_fn
        echo
	fi
    pushd "${PHOENIX_OSX_INTEL_DIR}"
	echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-osx-intel.zip..."
	"${PHOENIX_ZIP}" "${PHOENIX_ARCHIVES}/phoenix-osx-intel.zip" * -x 'Library/*' || error_fn
    echo
    popd
fi

if [ "${PHOENIX_WINDOWS}" == 1 ]; then
	if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    	"${PHOENIX_DOT_CLEAN}" "${PHOENIX_WINDOWS_DIR}" || error_fn
        echo
	fi
    pushd "${PHOENIX_WINDOWS_DIR}"
	echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-windows.zip..."
	"${PHOENIX_ZIP}" "${PHOENIX_ARCHIVES}/phoenix-windows.zip" * || error_fn
    echo
    popd
fi
