#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Set up target parameters
if [[ -z "${1+x}" ]]; then
  readonly target='all'
else
  readonly target=$(echo "${1}" | "${PHOENIX_AWK}" '{print tolower($0)}')
fi

if [[ -z "${2+x}" ]]; then
  readonly mode='download'
else
  readonly mode=$(echo "${2}" | "${PHOENIX_AWK}" '{print tolower($0)}')
fi

# Get sources
readonly PHOENIX_FROM_SOURCES=1
export PHOENIX_FROM_SOURCES
if [ "${PHOENIX_LOG_SOURCES}" == 1 ]; then
  readonly SOURCES_LOG_FILE="${PHOENIX_LOG_DIR}/get_sources.log"

  # If the log file already exists, remove it
  if [ -f "${SOURCES_LOG_FILE}" ]; then
    rm "${SOURCES_LOG_FILE}"
  fi

  # Ensure our log directory exists
  mkdir -vp "${PHOENIX_LOG_DIR}"

  bash -x "${PHOENIX_SCRIPTS}/get_sources-phoenix.sh" "${target}" "${mode}" > >(tee -a "${SOURCES_LOG_FILE}") 2>&1
else
  bash -x "${PHOENIX_SCRIPTS}/get_sources-phoenix.sh" "${target}" "${mode}"
fi
