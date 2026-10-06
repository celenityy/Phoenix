#!/bin/bash

# Phoenix environment variables

set -euo pipefail

# Set `PHOENIX_ROOT`
function set_root() {
  # If `PHOENIX_ROOT` is already set to a valid directory, we're done
  if [[ -n "${PHOENIX_ROOT+x}" ]] && [[ -d "${PHOENIX_ROOT}" ]]; then
    readonly PHOENIX_ROOT
    return 0
  fi

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

  local -r root_txt="$("${dirname}" $0)/root.txt"

  if [[ ! -f "${root_txt}" ]]; then
    readonly PHOENIX_ROOT=$(cd "$("${dirname}" "${BASH_SOURCE[0]}")/.." && pwd)
    if [[ -d "${PHOENIX_ROOT}" ]]; then
      echo -n "${PHOENIX_ROOT}" > "${root_txt}" || exit 1
    else
      echo "ERROR: Unable to find a valid root directory: '${PHOENIX_ROOT}'!"
      exit 1
    fi
  else
    # Find cat
    if [[ -n "${PHOENIX_CAT+x}" ]] && [[ -x "${PHOENIX_CAT}" ]]; then
      local -r cat="${PHOENIX_CAT}"
    elif [[ -x '/bin/cat' ]]; then
      local -r cat='/bin/cat'
    elif [[ -x '/usr/bin/cat' ]]; then
      local -r cat='/usr/bin/cat'
    else
      if ! command -v cat > /dev/null 2>&1; then
        echo "ERROR: Missing cat!" >&2
        exit 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r cat="$(cat)"
    fi

    # Find xargs
    if [[ -n "${PHOENIX_XARGS+x}" ]] && [[ -x "${PHOENIX_XARGS}" ]]; then
      local -r xargs="${PHOENIX_XARGS}"
    elif [[ -x '/bin/xargs' ]]; then
      local -r xargs='/bin/xargs'
    elif [[ -x '/usr/bin/xargs' ]]; then
      local -r xargs='/usr/bin/xargs'
    else
      if ! command -v xargs > /dev/null 2>&1; then
        echo "ERROR: Missing xargs!" >&2
        exit 1
      fi
      # It isn't a known location, so we sadly have to just fall-back to the PATH
      local -r xargs="$(xargs)"
    fi

    readonly PHOENIX_ROOT=$("${cat}" "${root_txt}" | "${xargs}")

    if [[ ! -d "${PHOENIX_ROOT}" ]]; then
      echo "ERROR: Unable to find a valid root directory: '${PHOENIX_ROOT}'!"
      exit 1
    fi
  fi
}

# Add an executable to Phoenix's PATH
## If the executable is not valid, a warning is displayed instead
function add_to_path() {
  function print_usage() {
    echo "Usage: add_to_path '/path/to/PATH' '/path/to/executable' 'executable_env_var' 'executable'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text "ERROR: Please specify the PATH's path!"
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to an executable!'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text "ERROR: Please specify the executable's environment variable!"
    print_usage
    exit 1
  fi

  if [[ -z "${4+x}" ]]; then
    echo_red_text 'ERROR: Please specify the executable name!'
    print_usage
    exit 1
  fi

  # Ensure we have ln
  verify_exec "${PHOENIX_LN}" 'PHOENIX_LN' || exit 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

  local -r path="$1"
  local -r exec="$2"
  local -r exec_env="$3"
  local -r exec_name="$4"

  # Create our PATH directory if necessary
  if [[ ! -d "${path}" ]]; then
    "${PHOENIX_MKDIR}" -p "${path}"
  fi

  if verify_env "${exec}" "${exec_env}"; then
    # If our target already exists on the path, remove it
    if [[ -f "${path}/${exec_name}" ]]; then
      "${PHOENIX_RM}" -f "${path}/${exec_name}"
    fi
    "${PHOENIX_LN}" -sf "${exec}" "${path}/${exec_name}"
    echo_green_text "Added '${exec_name}' to PATH (from '${exec_env}')!"
  else
    echo_red_text "WARNING: Unable to add '${exec_name}' to PATH!"
    echo "Please ensure that '${exec_env}' is set to a valid location."
  fi
}

# Add an executable to Phoenix's full PATH
function add_to_full_path() {
  function print_usage() {
    echo "Usage: add_to_full_path '/path/to/executable' 'executable_env_var' 'executable'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to an executable!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text "ERROR: Please specify the executable's environment variable!"
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the executable name!'
    print_usage
    exit 1
  fi

  # Ensure we have `PHOENIX_PATH`
  verify_env "${PHOENIX_PATH}" 'PHOENIX_PATH' || exit 1

  local -r exec="$1"
  local -r exec_env="$2"
  local -r exec_name="$3"

  add_to_path "${PHOENIX_PATH}" "${exec}" "${exec_env}" "${exec_name}"
}

# Add an executable to Phoenix's lint PATH
function add_to_lint_path() {
  function print_usage() {
    echo "Usage: add_to_lint_path '/path/to/executable' 'executable_env_var' 'executable'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to an executable!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text "ERROR: Please specify the executable's environment variable!"
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the executable name!'
    print_usage
    exit 1
  fi

  # Ensure we have `PHOENIX_LINT_PATH`
  verify_env "${PHOENIX_LINT_PATH}" 'PHOENIX_LINT_PATH' || exit 1

  local -r exec="$1"
  local -r exec_env="$2"
  local -r exec_name="$3"

  add_to_path "${PHOENIX_LINT_PATH}" "${exec}" "${exec_env}" "${exec_name}"
}

# Set-up the full Phoenix PATH
function setup_path() {
  # Ensure we have `PHOENIX_CI`
  verify_env "${PHOENIX_CI}" 'PHOENIX_CI' || exit 1

  # Ensure we have `PHOENIX_PLATFORM`
  verify_env "${PHOENIX_PLATFORM}" 'PHOENIX_PLATFORM' || exit 1

  add_to_full_path "${PHOENIX_AWK}" 'PHOENIX_AWK' 'awk'
  add_to_full_path "${PHOENIX_AWK}" 'PHOENIX_AWK' 'gawk'
  add_to_full_path "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' 'basename'
  add_to_full_path "${PHOENIX_BASH}" 'PHOENIX_BASH' 'bash'
  add_to_full_path "${PHOENIX_CAT}" 'PHOENIX_CAT' 'cat'
  add_to_full_path "${PHOENIX_CHMOD}" 'PHOENIX_CHMOD' 'chmod'
  add_to_full_path "${PHOENIX_CP}" 'PHOENIX_CP' 'cp'
  add_to_full_path "${PHOENIX_CURL}" 'PHOENIX_CURL' 'curl'
  add_to_full_path "${PHOENIX_DATE}" 'PHOENIX_DATE' 'date'
  add_to_full_path "${PHOENIX_DATE}" 'PHOENIX_DATE' 'gdate'
  add_to_full_path "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' 'dirname'
  add_to_full_path "${PHOENIX_ECHO}" 'PHOENIX_ECHO' 'echo'
  add_to_full_path "${PHOENIX_FIND}" 'PHOENIX_FIND' 'find'
  add_to_full_path "${PHOENIX_GIT}" 'PHOENIX_GIT' 'git'
  add_to_full_path "${PHOENIX_GREP}" 'PHOENIX_GREP' 'grep'
  add_to_full_path "${PHOENIX_GZIP}" 'PHOENIX_GZIP' 'gzip'
  add_to_full_path "${PHOENIX_HEAD}" 'PHOENIX_HEAD' 'head'
  add_to_full_path "${PHOENIX_JQ}" 'PHOENIX_JQ' 'jq'
  add_to_full_path "${PHOENIX_LN}" 'PHOENIX_LN' 'ln'
  add_to_full_path "${PHOENIX_LS}" 'PHOENIX_LS' 'ls'
  add_to_full_path "${PHOENIX_MD5SUM}" 'PHOENIX_MD5SUM' 'md5sum'
  add_to_full_path "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' 'mkdir'
  add_to_full_path "${PHOENIX_PYTHON}" 'PHOENIX_PYTHON' 'python'
  add_to_full_path "${PHOENIX_PYTHON}" 'PHOENIX_PYTHON' 'python3'
  add_to_full_path "${PHOENIX_PYTHON}" 'PHOENIX_PYTHON' 'python3.14'
  add_to_full_path "${PHOENIX_RM}" 'PHOENIX_RM' 'rm'
  add_to_full_path "${PHOENIX_S3CMD}" 'PHOENIX_S3CMD' 's3cmd'
  add_to_full_path "${PHOENIX_SED}" 'PHOENIX_SED' 'gsed'
  add_to_full_path "${PHOENIX_SED}" 'PHOENIX_SED' 'sed'
  add_to_full_path "${PHOENIX_SH}" 'PHOENIX_SH' 'sh'
  add_to_full_path "${PHOENIX_SHASUM}" 'PHOENIX_SHASUM' 'shasum'
  add_to_full_path "${PHOENIX_TAR}" 'PHOENIX_TAR' 'gtar'
  add_to_full_path "${PHOENIX_TAR}" 'PHOENIX_TAR' 'tar'
  add_to_full_path "${PHOENIX_TEE}" 'PHOENIX_TEE' 'tee'
  add_to_full_path "${PHOENIX_TOUCH}" 'PHOENIX_TOUCH' 'touch'
  add_to_full_path "${PHOENIX_UNAME}" 'PHOENIX_UNAME' 'uname'
  add_to_full_path "${PHOENIX_UNZIP}" 'PHOENIX_UNZIP' 'unzip'
  add_to_full_path "${PHOENIX_UV}" 'PHOENIX_UV' 'uv'
  add_to_full_path "${PHOENIX_XARGS}" 'PHOENIX_XARGS' 'xargs'
  add_to_full_path "${PHOENIX_XZ}" 'PHOENIX_XZ' 'xz'
  add_to_full_path "${PHOENIX_ZIP}" 'PHOENIX_ZIP' 'zip'

  # CI-specific
  if [[ "${PHOENIX_CI}" == 1 ]]; then
    add_to_full_path "${PHOENIX_RSYNC}" 'PHOENIX_RSYNC' 'rsync'
  fi

  # OS X-specific
  if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
    add_to_full_path "${PHOENIX_DOT_CLEAN}" 'PHOENIX_DOT_CLEAN' 'dot_clean'
  fi

  PATH="${PHOENIX_PATH}"
  export PATH
}

# Set-up a minimal PATH for linting
function setup_lint_path() {
  add_to_lint_path "${PHOENIX_BASH}" 'PHOENIX_BASH' 'bash'
  add_to_lint_path "${PHOENIX_GIT}" 'PHOENIX_GIT' 'git'
  add_to_lint_path "${PHOENIX_SHELLCHECK}" 'PHOENIX_SHELLCHECK' 'shellcheck'
  add_to_lint_path "${PHOENIX_SH}" 'PHOENIX_SH' 'sh'
  add_to_lint_path "${PHOENIX_SHFMT}" 'PHOENIX_SHFMT' 'shfmt'

  readonly PATH="${PHOENIX_LINT_PATH}"
  export PATH
}

# For CI, ensure external environment variables are set
function setup_ci() {
  # Ensure our CI type is set
  if [[ -z "${PHOENIX_CI_TYPE+x}" ]] || [[ "${PHOENIX_CI_TYPE}" == "" ]] ||
    [[ "${PHOENIX_CI_TYPE}" == "null" ]]; then
    echo "ERROR: Missing CI type! Please set 'PHOENIX_CI_TYPE'."
    exit 1
  fi

  # Ensure our branches are set
  if [[ -z "${PHOENIX_DEV_BRANCH+x}" ]] || [[ "${PHOENIX_DEV_BRANCH}" == "" ]] ||
    [[ "${PHOENIX_DEV_BRANCH}" == "null" ]]; then
    echo "ERROR: Missing developer branch! Please set 'PHOENIX_DEV_BRANCH'."
    exit 1
  fi

  if [[ -z "${PHOENIX_PROD_BRANCH+x}" ]] || [[ "${PHOENIX_PROD_BRANCH}" == "" ]] ||
    [[ "${PHOENIX_PROD_BRANCH}" == "null" ]]; then
    echo "ERROR: Missing production branch! Please set 'PHOENIX_PROD_BRANCH'."
    exit 1
  fi
}

# Remove the legacy `env_local.sh`
function clean_env_local() {
  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

  if [[ -f "$(dirname $0)/env_local.sh" ]]; then
    "${PHOENIX_RM}" -f "$(dirname $0)/env_local.sh"
  fi
}

# Set-up our environment
function set_env() {
  if [[ -z "${PHOENIX_SET_ENVS+x}" ]] || [[ "${PHOENIX_SET_ENVS}" != 1 ]]; then
    # Get our root directory
    set_root || exit 1

    # Ensure we have `PHOENIX_ROOT`
    if [[ -z "${PHOENIX_ROOT+x}" ]] || [[ ! -d "${PHOENIX_ROOT}" ]]; then
      echo "ERROR: 'PHOENIX_ROOT' is missing or invalid!"
      exit 1
    fi

    # Do not use the system PATH
    unset PATH || exit 1
    hash -r || exit 1

    # Handle CI-specific logic
    if [[ -n "${PHOENIX_CI+x}" ]]; then
      setup_ci || exit 1
    fi

    source "${PHOENIX_ROOT}/scripts/env_common.sh" || exit 1

    # Include utilities
    if [[ -z "${PHOENIX_UTILS+x}" ]] || [[ ! -f "${PHOENIX_UTILS}" ]] || [[ ! -s "${PHOENIX_UTILS}" ]]; then
      echo "ERROR: 'PHOENIX_UTILS' is missing or invalid!"
      exit 1
    fi
    source "${PHOENIX_UTILS}" || exit 1

    # Set-up our PATH
    if [[ -n "${PHOENIX_LINTING+x}" ]]; then
      setup_lint_path || exit 1
    else
      setup_path || exit 1
    fi

    # Clean-up the old `env_local.sh` (if necessary)
    clean_env_local
  fi
}

# Set-up our environment
set_env
