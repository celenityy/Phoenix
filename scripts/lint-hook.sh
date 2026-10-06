#!/bin/bash

# Script to configure a git pre-commit hook for linting

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

# Set verbosity
set_verbosity

# Ensure we have git
verify_exec "${PHOENIX_GIT}" 'PHOENIX_GIT' || exit 1

# Ensure we have mkdir
verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

# Ensure we have rm
verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

# Ensure we have touch
verify_exec "${PHOENIX_TOUCH}" 'PHOENIX_TOUCH' || exit 1

# Ensure we have `PHOENIX_BUILD`
verify_env "${PHOENIX_BUILD}" 'PHOENIX_BUILD' || exit 1

# Check if the hook has already been set-up
if [[ -f "${PHOENIX_BUILD}/set-hook" ]]; then
  echo_red_text 'It looks like the git pre-commit hook has already been set-up!'
  read -p "Are you sure you want to continue? [y/N] " -n 1 -r
  echo
  if [[ "${REPLY}" =~ ^[Nn]$ ]]; then
    exit 0
  else
    "${PHOENIX_RM}" -f "${PHOENIX_BUILD}/set-hook"
  fi
fi

# Enable the pre-commit hook so shell scripts are linted (shellcheck + shfmt)
# before each commit. CI enforces the same checks, so this is just a fast local
# safeguard (and is bypassable with `git commit --no-verify`).
echo_red_text 'Configuring git pre-commit hook...'
"${PHOENIX_GIT}" -C "${PHOENIX_ROOT}" config core.hooksPath scripts/git-hooks
echo_green_text 'SUCCESS: Configured git pre-commit hook'

# Indicate that the hook has been set-up
"${PHOENIX_MKDIR}" -p "${PHOENIX_BUILD}"
"${PHOENIX_TOUCH}" "${PHOENIX_BUILD}/set-hook"
