#!/bin/bash

set -euo pipefail

# Functions
function echo_red_text() {
	echo -e "\033[31m$1\033[0m"
}

function echo_green_text() {
	echo -e "\033[32m$1\033[0m"
}

function error_fn() {
	echo
	echo_red_text 'Something went wrong! The script failed.'
	echo_red_text 'Please report this (with the output message) to https://phoenix.celenity.dev/issues'
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

if [ "${PHOENIX_LOG_BUILD}" == 1 ]; then
    BUILD_LOG_FILE="${PHOENIX_LOG_DIR}/build.log"

    # If the log file already exists, remove it
    if [ -f "${BUILD_LOG_FILE}" ]; then
        rm "${BUILD_LOG_FILE}"
    fi

    # Ensure our log directory exists
    mkdir -vp "${PHOENIX_LOG_DIR}"

    bash -x "${PHOENIX_BUILD}/fly.sh" > >(tee -a "${BUILD_LOG_FILE}") 2>&1 || error_fn
    echo

    bash -x "${PHOENIX_BUILD}/gen_archive.sh" > >(tee -a "${BUILD_LOG_FILE}") 2>&1 || error_fn
    echo
else
    bash -x "${PHOENIX_BUILD}/fly.sh" || error_fn
    echo

    bash -x "${PHOENIX_BUILD}/gen_archive.sh" || error_fn
    echo
fi

popd || error_fn
echo
