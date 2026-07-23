#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target='all'
else
  readonly target=$(echo "${1}" | "${PHOENIX_AWK}" '{print tolower($0)}')
fi

# Include utilities
source "${PHOENIX_UTILS}"

pushd "${PHOENIX_ROOT}"

# Build Phoenix
readonly PHOENIX_FROM_BUILD=1
export PHOENIX_FROM_BUILD
if [[ "${PHOENIX_LOG_BUILD}" == 1 ]]; then
  readonly BUILD_LOG_FILE="${PHOENIX_LOG_DIR}/build.log"

  # If the log file already exists, remove it
  if [[ -f "${BUILD_LOG_FILE}" ]]; then
    "${PHOENIX_RM}" "${BUILD_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${PHOENIX_MKDIR}" -vp "${PHOENIX_LOG_DIR}"

  /bin/bash -x "${PHOENIX_SCRIPTS}/fly.sh" "${target}" > >("${PHOENIX_TEE}" -a "${BUILD_LOG_FILE}") 2>&1
else
  /bin/bash -x "${PHOENIX_SCRIPTS}/fly.sh" "${target}"
fi

popd
