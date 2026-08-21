#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: $0 should only be called from CI!"
  exit 1
fi

# Set our CI ID
## For Forgejo (Codeberg), we use the run ID
## For GitLab, we use the pipeline ID
if [[ "${PHOENIX_CI_TYPE}" == 'forgejo' ]]; then
  if [[ -z "${FORGEJO_RUN_ID+x}" ]]; then
    echo_red_text 'ERROR: Missing Forgejo run ID! Please set FORGEJO_RUN_ID.'
    exit 1
  else
    readonly PHOENIX_CI_ID="${FORGEJO_RUN_ID}"
  fi
elif [[ "${PHOENIX_CI_TYPE}" == 'gitlab' ]]; then
  if [[ -z "${CI_PIPELINE_ID+x}" ]]; then
    echo_red_text 'ERROR: Missing GitLab pipeline ID! Please set CI_PIPELINE_ID.'
    exit 1
  else
    readonly PHOENIX_CI_ID="${CI_PIPELINE_ID}"
  fi
else
  echo_red_text "ERRROR: Unknown CI type!: ${PHOENIX_CI_TYPE}"
  exit 1
fi
export PHOENIX_CI_ID

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target_artifact='all'
else
  readonly target_artifact=$(echo "${1}" | "${PHOENIX_AWK}" '{print tolower($0)}')
fi

# Upload our artifacts
readonly PHOENIX_FROM_AR_UP=1
export PHOENIX_FROM_AR_UP
if [[ "${PHOENIX_LOG_AR_UP}" == 1 ]]; then
  readonly AR_UP_LOG_FILE="${PHOENIX_LOG_DIR}/upload-artifacts-${PHOENIX_CI_ID}-${target_artifact}.log"

  # If the log file already exists, remove it
  if [[ -f "${AR_UP_LOG_FILE}" ]]; then
    "${PHOENIX_RM}" "${AR_UP_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${PHOENIX_MKDIR}" -vp "${PHOENIX_LOG_DIR}"

  /bin/bash "${PHOENIX_SCRIPTS}/ci-upload-artifacts-phoenix.sh" "${target_artifact}" > >("${PHOENIX_TEE}" -a "${AR_UP_LOG_FILE}") 2>&1
else
  /bin/bash "${PHOENIX_SCRIPTS}/ci-upload-artifacts-phoenix.sh" "${target_artifact}"
fi
