#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

pushd "${PHOENIX_ROOT}"

# Build Phoenix
readonly PHOENIX_FROM_BUILD=1
export PHOENIX_FROM_BUILD
if [ "${PHOENIX_LOG_BUILD}" == 1 ]; then
  readonly BUILD_LOG_FILE="${PHOENIX_LOG_DIR}/build.log"

  # If the log file already exists, remove it
  if [ -f "${BUILD_LOG_FILE}" ]; then
    rm "${BUILD_LOG_FILE}"
  fi

  # Ensure our log directory exists
  mkdir -vp "${PHOENIX_LOG_DIR}"

  bash -x "${PHOENIX_SCRIPTS}/fly.sh" > >(tee -a "${BUILD_LOG_FILE}") 2>&1
else
  bash -x "${PHOENIX_SCRIPTS}/fly.sh"
fi

popd
