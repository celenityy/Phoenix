#!/bin/bash

set -euo pipefail

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
