#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_CI+x}" ]]; then
  export PHOENIX_CI=1
fi
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

# Push Phoenix
readonly PHOENIX_FROM_PUSH=1
export PHOENIX_FROM_PUSH
if [[ "${PHOENIX_LOG_PUSH}" == 1 ]]; then
  readonly PUSH_LOG_FILE="${PHOENIX_LOG_DIR}/push.log"

  # If the log file already exists, remove it
  if [[ -f "${PUSH_LOG_FILE}" ]]; then
    "${PHOENIX_RM}" "${PUSH_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${PHOENIX_MKDIR}" -vp "${PHOENIX_LOG_DIR}"

  /bin/bash "${PHOENIX_SCRIPTS}/push-phoenix.sh" > >("${PHOENIX_TEE}" -a "${PUSH_LOG_FILE}") 2>&1
else
  /bin/bash "${PHOENIX_SCRIPTS}/push-phoenix.sh"
fi
