#!/bin/bash

# Phoenix environment variables

set -euo pipefail

if [[ ! -f "$(dirname $0)/env_local.sh" ]]; then
  readonly ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  readonly ENV_LOCAL="${ROOT}/scripts/env_local.sh"

  # Write env_local.sh
  echo "Writing ${ENV_LOCAL}..."
  cat > "${ENV_LOCAL}" << EOF
# shellcheck shell=bash
readonly PHOENIX_ROOT="${ROOT}"
export PHOENIX_ROOT

source "\${PHOENIX_ROOT}/scripts/env_common.sh"
EOF
fi

# Set-up the full Phoenix PATH
function setup_path() {
  "${PHOENIX_RM}" -rf "${PHOENIX_PATH}"
  "${PHOENIX_MKDIR}" -p "${PHOENIX_PATH}"

  "${PHOENIX_LN}" -sf "${PHOENIX_AWK}" "${PHOENIX_PATH}/awk"
  "${PHOENIX_LN}" -sf "${PHOENIX_AWK}" "${PHOENIX_PATH}/gawk"
  "${PHOENIX_LN}" -sf "${PHOENIX_BASENAME}" "${PHOENIX_PATH}/basename"
  "${PHOENIX_LN}" -sf "${PHOENIX_CAT}" "${PHOENIX_PATH}/cat"
  "${PHOENIX_LN}" -sf "${PHOENIX_CHMOD}" "${PHOENIX_PATH}/chmod"
  "${PHOENIX_LN}" -sf "${PHOENIX_CP}" "${PHOENIX_PATH}/cp"
  "${PHOENIX_LN}" -sf "${PHOENIX_CURL}" "${PHOENIX_PATH}/curl"
  "${PHOENIX_LN}" -sf "${PHOENIX_DATE}" "${PHOENIX_PATH}/date"
  "${PHOENIX_LN}" -sf "${PHOENIX_DATE}" "${PHOENIX_PATH}/gdate"
  "${PHOENIX_LN}" -sf "${PHOENIX_DIRNAME}" "${PHOENIX_PATH}/dirname"
  "${PHOENIX_LN}" -sf "${PHOENIX_ECHO}" "${PHOENIX_PATH}/echo"
  "${PHOENIX_LN}" -sf "${PHOENIX_FIND}" "${PHOENIX_PATH}/find"
  "${PHOENIX_LN}" -sf "${PHOENIX_GIT}" "${PHOENIX_PATH}/git"
  "${PHOENIX_LN}" -sf "${PHOENIX_GREP}" "${PHOENIX_PATH}/grep"
  "${PHOENIX_LN}" -sf "${PHOENIX_GZIP}" "${PHOENIX_PATH}/gzip"
  "${PHOENIX_LN}" -sf "${PHOENIX_HEAD}" "${PHOENIX_PATH}/head"
  "${PHOENIX_LN}" -sf "${PHOENIX_JQ}" "${PHOENIX_PATH}/jq"
  "${PHOENIX_LN}" -sf "${PHOENIX_LN}" "${PHOENIX_PATH}/ln"
  "${PHOENIX_LN}" -sf "${PHOENIX_LS}" "${PHOENIX_PATH}/ls"
  "${PHOENIX_LN}" -sf "${PHOENIX_MD5SUM}" "${PHOENIX_PATH}/md5sum"
  "${PHOENIX_LN}" -sf "${PHOENIX_MKDIR}" "${PHOENIX_PATH}/mkdir"
  "${PHOENIX_LN}" -sf "${PHOENIX_PYTHON}" "${PHOENIX_PATH}/python"
  "${PHOENIX_LN}" -sf "${PHOENIX_PYTHON}" "${PHOENIX_PATH}/python3"
  "${PHOENIX_LN}" -sf "${PHOENIX_PYTHON}" "${PHOENIX_PATH}/python3.14"
  "${PHOENIX_LN}" -sf "${PHOENIX_RM}" "${PHOENIX_PATH}/rm"
  "${PHOENIX_LN}" -sf "${PHOENIX_S3CMD}" "${PHOENIX_PATH}/s3cmd"
  "${PHOENIX_LN}" -sf "${PHOENIX_SED}" "${PHOENIX_PATH}/gsed"
  "${PHOENIX_LN}" -sf "${PHOENIX_SED}" "${PHOENIX_PATH}/sed"
  "${PHOENIX_LN}" -sf "${PHOENIX_SHASUM}" "${PHOENIX_PATH}/shasum"
  "${PHOENIX_LN}" -sf "${PHOENIX_TAR}" "${PHOENIX_PATH}/gtar"
  "${PHOENIX_LN}" -sf "${PHOENIX_TAR}" "${PHOENIX_PATH}/tar"
  "${PHOENIX_LN}" -sf "${PHOENIX_TEE}" "${PHOENIX_PATH}/tee"
  "${PHOENIX_LN}" -sf "${PHOENIX_TOUCH}" "${PHOENIX_PATH}/touch"
  "${PHOENIX_LN}" -sf "${PHOENIX_UNAME}" "${PHOENIX_PATH}/uname"
  "${PHOENIX_LN}" -sf "${PHOENIX_UNZIP}" "${PHOENIX_PATH}/unzip"
  "${PHOENIX_LN}" -sf "${PHOENIX_UV}" "${PHOENIX_PATH}/uv"
  "${PHOENIX_LN}" -sf "${PHOENIX_XARGS}" "${PHOENIX_PATH}/xargs"
  "${PHOENIX_LN}" -sf "${PHOENIX_XZ}" "${PHOENIX_PATH}/xz"
  "${PHOENIX_LN}" -sf "${PHOENIX_ZIP}" "${PHOENIX_PATH}/zip"

  # OS X-specific
  if [[ "${PHOENIX_PLATFORM}" == 'darwin' ]]; then
    "${PHOENIX_LN}" -sf "${PHOENIX_DOT_CLEAN}" "${PHOENIX_PATH}/dot_clean"
  fi

  readonly PATH="${PHOENIX_PATH}"
  export PATH
}

# Set-up a minimal PATH for linting
function setup_lint_path() {
  "${PHOENIX_RM}" -rf "${PHOENIX_LINT_PATH}"
  "${PHOENIX_MKDIR}" -p "${PHOENIX_LINT_PATH}"

  "${PHOENIX_LN}" -sf "${PHOENIX_GIT}" "${PHOENIX_LINT_PATH}/git"
  "${PHOENIX_LN}" -sf "${PHOENIX_SHELLCHECK}" "${PHOENIX_LINT_PATH}/shellcheck"
  "${PHOENIX_LN}" -sf "${PHOENIX_SHFMT}" "${PHOENIX_LINT_PATH}/shfmt"

  readonly PATH="${PHOENIX_LINT_PATH}"
  export PATH
}

if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  source "$(dirname $0)/env_local.sh"

  # Set-up our PATH
  if [[ -z "${PHOENIX_LINTING+x}" ]]; then
    setup_path
  else
    setup_lint_path
  fi
fi
