#!/bin/bash

set -euo pipefail

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from the 'archives' or `build` folder...

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
    bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

rm -rf "${PHOENIX_ARCHIVES}/*" || error_fn
echo

# dot_clean for OS X
readonly PHOENIX_DOT_CLEAN='/usr/sbin/dot_clean -mv'

# zip
if [ "${PHOENIX_NIX}" == 1 ]; then
    readonly PHOENIX_ZIP='zip -r'
    rm "${PHOENIX_ARCHIVES}/phoenix-linux.zip"
else
    readonly PHOENIX_ZIP='zip -r -FS'
fi

if [ "${PHOENIX_LINUX}" == 1 ]; then
    if [[ "${PHOENIX_OS}" == 'osx' ]]; then
        ${PHOENIX_DOT_CLEAN} "${PHOENIX_LINUX_OUTPUTS}" || error_fn
        echo
    fi

    pushd "${PHOENIX_LINUX_OUTPUTS}" || error_fn
    echo
    echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-linux.zip..."
    ${PHOENIX_ZIP} "${PHOENIX_ARCHIVES}/phoenix-linux.zip" * -x 'unused/*' || error_fn
    echo
    popd || error_fn
    echo
fi

if [ "${PHOENIX_LINUX_FLATPAK}" == 1 ]; then
	if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    	${PHOENIX_DOT_CLEAN} "${PHOENIX_LINUX_FLATPAK_OUTPUTS}" || error_fn
        echo
	fi
    pushd "${PHOENIX_LINUX_FLATPAK_OUTPUTS}" || error_fn
    echo
	echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-flatpak.zip..."
	${PHOENIX_ZIP} "${PHOENIX_ARCHIVES}/phoenix-flatpak.zip" * -x 'unused/*' || error_fn
    echo
    popd || error_fn
    echo
fi

if [ "${PHOENIX_OSX}" == 1 ]; then
	if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    	${PHOENIX_DOT_CLEAN} "${PHOENIX_OSX_OUTPUTS}" || error_fn
        echo
	fi
    pushd "${PHOENIX_OSX_OUTPUTS}" || error_fn
    echo
	echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-osx.zip..."
	${PHOENIX_ZIP} "${PHOENIX_ARCHIVES}/phoenix-osx.zip" * -x 'Library/*' 'unused/*' || error_fn
    echo
    popd || error_fn
    echo
fi

if [ "${PHOENIX_OSX_INTEL}" == 1 ]; then
	if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    	${PHOENIX_DOT_CLEAN} "${PHOENIX_OSX_INTEL_OUTPUTS}" || error_fn
        echo
	fi
    pushd "${PHOENIX_OSX_INTEL_OUTPUTS}" || error_fn
    echo
	echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-osx-intel.zip..."
	${PHOENIX_ZIP} "${PHOENIX_ARCHIVES}/phoenix-osx-intel.zip" * -x 'Library/*' 'unused/*' || error_fn
    echo
    popd || error_fn
    echo
fi

if [ "${PHOENIX_WINDOWS}" == 1 ]; then
	if [[ "${PHOENIX_OS}" == 'osx' ]]; then
    	${PHOENIX_DOT_CLEAN} "${PHOENIX_WINDOWS_OUTPUTS}" || error_fn
        echo
	fi
    pushd "${PHOENIX_WINDOWS_OUTPUTS}" || error_fn
    echo
	echo_green_text "Creating ${PHOENIX_ARCHIVES}/phoenix-windows.zip..."
	${PHOENIX_ZIP} "${PHOENIX_ARCHIVES}/phoenix-windows.zip" * -x 'unused/*' || error_fn
    echo
    popd || error_fn
    echo
fi
