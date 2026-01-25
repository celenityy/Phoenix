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

# Set-up our environment
bash -x $(dirname $0)/env.sh || error_fn
echo
source $(dirname $0)/env.sh || error_fn
echo

pushd "${PHOENIX_ROOT}" || error_fn
echo
bash -x "${PHOENIX_BUILD}/fly.sh" || error_fn
echo
bash -x "${PHOENIX_BUILD}/gen_archive.sh" || error_fn
echo
popd || error_fn
echo
