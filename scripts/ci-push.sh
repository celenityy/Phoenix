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

# Ensure we have `PHOENIX_CI`
verify_env "${PHOENIX_CI}" 'PHOENIX_CI' || exit 1

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
  exit 1
fi

# Ensure we have `PHOENIX_LOG_PUSH`
verify_env "${PHOENIX_LOG_PUSH}" 'PHOENIX_LOG_PUSH' || exit 1

# Ensure we have `PHOENIX_SCRIPTS`
verify_dir_with_env "${PHOENIX_SCRIPTS}" 'PHOENIX_SCRIPTS' || exit 1

# Ensure we have our target script
readonly PHOENIX_PUSH_SH="${PHOENIX_SCRIPTS}/ci-push-phoenix.sh"
verify_file "${PHOENIX_PUSH_SH}" || exit 1

# Push Phoenix
readonly PHOENIX_FROM_PUSH=1
export PHOENIX_FROM_PUSH
if [[ "${PHOENIX_LOG_PUSH}" == 1 ]]; then
  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

  # Ensure we have tee
  verify_exec "${PHOENIX_TEE}" 'PHOENIX_TEE' || exit 1

  # Ensure we have `PHOENIX_LOG_DIR`
  verify_env "${PHOENIX_LOG_DIR}" 'PHOENIX_LOG_DIR' || exit 1

  readonly PUSH_LOG_FILE="${PHOENIX_LOG_DIR}/push.log"

  # If the log file already exists, remove it
  if [[ -f "${PUSH_LOG_FILE}" ]]; then
    "${PHOENIX_RM}" "${PUSH_LOG_FILE}"
  fi

  # Ensure our log directory exists
  "${PHOENIX_MKDIR}" -vp "${PHOENIX_LOG_DIR}"

  source "${PHOENIX_PUSH_SH}" > >("${PHOENIX_TEE}" -a "${PUSH_LOG_FILE}") 2>&1 || exit 1
else
  source "${PHOENIX_PUSH_SH}" || exit 1
fi
