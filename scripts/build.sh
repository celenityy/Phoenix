#!/bin/bash

set -euo pipefail

# Set-up our environment
function setup_env() {
  if [[ -z "${PHOENIX_SET_ENVS+x}" ]] || [[ "${PHOENIX_SET_ENVS}" != 1 ]]; then
    # Find dirname
    if [[ -n "${PHOENIX_DIRNAME+x}" ]] && [[ -x "${PHOENIX_DIRNAME}" ]]; then
      local -r dirname="${PHOENIX_DIRNAME}"
    elif [[ -x '/bin/dirname' ]]; then
      local -r dirname='/bin/dirname'
    elif [[ -x '/usr/bin/dirname' ]]; then
      local -r dirname='/usr/bin/dirname'
    else
      if ! command -v dirname > /dev/null 2>&1; then
        echo "ERROR: Missing dirname!" >&2
        exit 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r dirname="$(dirname)"
    fi

    # Set-up our environment
    readonly PHOENIX_ENV_SH="$("${dirname}" $0)/env.sh"
    if [[ ! -f "${PHOENIX_ENV_SH}" ]] || [[ ! -s "${PHOENIX_ENV_SH}" ]]; then
      echo "ERROR: '${PHOENIX_ENV_SH}' is invalid!"
      exit 1
    fi
    source "${PHOENIX_ENV_SH}" || exit 1
  fi
}

# Set-up our environment
setup_env

# Ensure we have GNU awk
verify_exec "${PHOENIX_AWK}" 'PHOENIX_AWK' || exit 1

# Ensure we have `PHOENIX_SCRIPTS`
verify_dir_with_env "${PHOENIX_SCRIPTS}" 'PHOENIX_SCRIPTS' || exit 1

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  readonly build_target='all'
else
  readonly build_target=$(echo "${1}" | "${PHOENIX_AWK}" '{print tolower($0)}')
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

  # Ensure we have `PHOENIX_LOG_DIR`
  verify_env "${PHOENIX_LOG_DIR}" 'PHOENIX_LOG_DIR' || exit 1

  readonly BUILD_LOG_FILE="${PHOENIX_LOG_DIR}/build.log"

  # If the log file already exists, remove it
  if [[ -f "${BUILD_LOG_FILE}" ]]; then
    "${PHOENIX_RM}" "${BUILD_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${PHOENIX_MKDIR}" -vp "${PHOENIX_LOG_DIR}"

  source "${PHOENIX_SCRIPTS}/fly.sh" "${build_target}" > >("${PHOENIX_TEE}" -a "${BUILD_LOG_FILE}") 2>&1 || exit 1
else
  source "${PHOENIX_SCRIPTS}/fly.sh" "${build_target}" || exit 1
fi

popd
