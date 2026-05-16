#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
    bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

# Set up target parameters
if [[ -z "${1+x}" ]]; then
    readonly target='all'
else
    readonly target=$(echo "${1}" | "${PHOENIX_AWK}" '{print tolower($0)}')
fi

# Push Phoenix
readonly PHOENIX_FROM_PUSH=1
export PHOENIX_FROM_PUSH
if [ "${PHOENIX_LOG_PUSH}" == 1 ]; then
    readonly PUSH_LOG_FILE="${PHOENIX_LOG_DIR}/push-${target}.log"

    # If the log file already exists, remove it
    if [ -f "${PUSH_LOG_FILE}" ]; then
        rm "${PUSH_LOG_FILE}"
    fi

    # Ensure our log directory exists
    mkdir -vp "${PHOENIX_LOG_DIR}"

    bash "${PHOENIX_SCRIPTS}/push-phoenix.sh" "${target}" > >(tee -a "${PUSH_LOG_FILE}") 2>&1
else
    bash "${PHOENIX_SCRIPTS}/push-phoenix.sh" "${target}"
fi
