#!/bin/bash

# Phoenix environment variables

set -euo pipefail

if [[ ! -f "$(dirname $0)/env_local.sh" ]]; then
  readonly ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  readonly ENV_LOCAL="${ROOT}/scripts/env_local.sh"

  # Write env_local.sh
  echo "Writing ${ENV_LOCAL}..."
  cat >"${ENV_LOCAL}" <<EOF
readonly PHOENIX_ROOT="${ROOT}"
export PHOENIX_ROOT

source "\${PHOENIX_ROOT}/scripts/env_common.sh"
EOF
fi

if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  source "$(dirname $0)/env_local.sh"

  # Set-up our PATH
  "${PHOENIX_RM}" -rf "${PHOENIX_PATH}"
  "${PHOENIX_MKDIR}" -p "${PHOENIX_PATH}"

  "${PHOENIX_LN}" -sf "${PHOENIX_AWK}"        "${PHOENIX_PATH}/awk"
  "${PHOENIX_LN}" -sf "${PHOENIX_AWK}"        "${PHOENIX_PATH}/gawk"
  "${PHOENIX_LN}" -sf "${PHOENIX_BASENAME}"   "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_CAT}"        "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_CHMOD}"      "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_CP}"         "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_CURL}"       "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_DATE}"       "${PHOENIX_PATH}/date"
  "${PHOENIX_LN}" -sf "${PHOENIX_DATE}"       "${PHOENIX_PATH}/gdate"
  "${PHOENIX_LN}" -sf "${PHOENIX_DIRNAME}"    "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_DOT_CLEAN}"  "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_FIND}"       "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_GIT}"        "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_GREP}"       "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_GZIP}"       "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_HEAD}"       "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_JQ}"         "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_LN}"         "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_LS}"         "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_MD5SUM}"     "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_MKDIR}"      "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_PYTHON}"     "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_RM}"         "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_S3CMD}"      "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_SED}"        "${PHOENIX_PATH}/gsed"
  "${PHOENIX_LN}" -sf "${PHOENIX_SED}"        "${PHOENIX_PATH}/sed"
  "${PHOENIX_LN}" -sf "${PHOENIX_SHA1SUM}"    "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_SHA256SUM}"  "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_SHA512SUM}"  "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_TAR}"        "${PHOENIX_PATH}/gtar"
  "${PHOENIX_LN}" -sf "${PHOENIX_TAR}"        "${PHOENIX_PATH}/tar"
  "${PHOENIX_LN}" -sf "${PHOENIX_TEE}"        "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_TOUCH}"      "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_UNZIP}"      "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_UV}"         "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_XARGS}"      "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_XZ}"         "${PHOENIX_PATH}/"
  "${PHOENIX_LN}" -sf "${PHOENIX_ZIP}"        "${PHOENIX_PATH}/"

  readonly PATH="${PHOENIX_PATH}"
  export PATH
fi
