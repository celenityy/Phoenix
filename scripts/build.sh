#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh || exit 1
fi
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${PHOENIX_UTILS}" || exit 1

# Ensure we have GNU awk
verify_exec "${PHOENIX_AWK}" 'PHOENIX_AWK' || exit 1

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target='all'
else
  readonly target=$(echo "${1}" | "${PHOENIX_AWK}" '{print tolower($0)}')
fi

pushd "${PHOENIX_ROOT}"

# Build Phoenix
readonly PHOENIX_FROM_BUILD=1
export PHOENIX_FROM_BUILD
if [[ "${PHOENIX_LOG_BUILD}" == 1 ]]; then
  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

  # Ensure we have tee
  verify_exec "${PHOENIX_TEE}" 'PHOENIX_TEE' || exit 1

  readonly BUILD_LOG_FILE="${PHOENIX_LOG_DIR}/build.log"

  # If the log file already exists, remove it
  if [[ -f "${BUILD_LOG_FILE}" ]]; then
    "${PHOENIX_RM}" "${BUILD_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${PHOENIX_MKDIR}" -vp "${PHOENIX_LOG_DIR}"

  /bin/bash "${PHOENIX_SCRIPTS}/fly.sh" "${target}" > >("${PHOENIX_TEE}" -a "${BUILD_LOG_FILE}") 2>&1 || exit 1
else
  /bin/bash "${PHOENIX_SCRIPTS}/fly.sh" "${target}" || exit 1
fi

popd
