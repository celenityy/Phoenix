#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x || exit 1

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh || exit 1
fi
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${PHOENIX_UTILS}" || exit 1

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: $0 should only be called from CI!"
  exit 1
fi

# Ensure we have GNU awk
verify_exec "${PHOENIX_AWK}" 'PHOENIX_AWK' || exit 1

# Set-up target parameters
if [[ -z "${1+x}" ]]; then
  echo_red_text "Usage: $0 s3-artifacts|s3-releases" >&1
  exit 1
fi

readonly ci_prep_target=$(echo "${1}" | "${PHOENIX_AWK}" '{print tolower($0)}')

PHOENIX_CI_PREP_S3_ARTIFACTS=0
PHOENIX_CI_PREP_S3_RELEASES=0

if [[ "${ci_prep_target}" == 's3-artifacts' ]]; then
  # Set-up S3 storage - Artifacts
  PHOENIX_CI_PREP_S3_ARTIFACTS=1
elif [[ "${ci_prep_target}" == 's3-releases' ]]; then
  # Set-up S3 storage - Releases
  PHOENIX_CI_PREP_S3_RELEASES=1
else
  echo_red_text "ERROR: Invalid target: ${ci_prep_target}\n You must enter one of the following:"
  echo 'S3 storage - Artifacts:  s3-artifacts'
  echo 'S3 storage - Releases:   s3-releases'
  exit 1
fi
readonly PHOENIX_CI_PREP_S3_ARTIFACTS
readonly PHOENIX_CI_PREP_S3_RELEASES

# Prepare secrets for S3 storage - Artifacts
function prep_s3_artifacts() {
  echo_red_text 'Preparing S3 storage - Artifacts...'

  # Ensure we have chmod
  verify_exec "${PHOENIX_CHMOD}" 'PHOENIX_CHMOD' || exit 1

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || exit 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

  # Ensure we have touch
  verify_exec "${PHOENIX_TOUCH}" 'PHOENIX_TOUCH' || exit 1

  # First, check environment variables specified externally (via CI)

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY`
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY+x}" ]] || [[ "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY}" == "" ]] ||
    [[ "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME`
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME+x}" ]] || [[ "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME}" == "" ]] ||
    [[ "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT`
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT+x}" ]] || [[ "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT}" == "" ]] ||
    [[ "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY`
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY+x}" ]] || [[ "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY}" == "" ]] ||
    [[ "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY' is missing!"
    exit 1
  fi

  # Now, check environment variables specified directly (via `env_ci.sh`/`env_common.sh`)

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE`
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE+x}" ]] || [[ "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" == "" ]] ||
    [[ "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE`
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE+x}" ]] || [[ "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" == "" ]] ||
    [[ "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE`
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE+x}" ]] || [[ "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" == "" ]] ||
    [[ "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE`
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE+x}" ]] || [[ "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" == "" ]] ||
    [[ "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE' is missing!"
    exit 1
  fi

  # Create our directories
  "${PHOENIX_MKDIR}" -p $("${PHOENIX_DIRNAME}" "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}")
  "${PHOENIX_MKDIR}" -p $("${PHOENIX_DIRNAME}" "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}")
  "${PHOENIX_MKDIR}" -p $("${PHOENIX_DIRNAME}" "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}")
  "${PHOENIX_MKDIR}" -p $("${PHOENIX_DIRNAME}" "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}")

  # Create the S3 access key file
  "${PHOENIX_TOUCH}" "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}"
  "${PHOENIX_CHMOD}" 600 "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}"
  echo -n "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY}" > "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}"

  # Create the S3 bucket name file
  "${PHOENIX_TOUCH}" "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}"
  "${PHOENIX_CHMOD}" 600 "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}"
  echo -n "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME}" > "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}"

  # Create the S3 endpoint file
  "${PHOENIX_TOUCH}" "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}"
  "${PHOENIX_CHMOD}" 600 "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}"
  echo -n "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT}" > "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}"

  # Create the S3 secret key file
  "${PHOENIX_TOUCH}" "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}"
  "${PHOENIX_CHMOD}" 600 "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}"
  echo -n "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY}" > "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}"

  # Ensure nothing went wrong...
  verify_file_with_env "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE' || exit 1
  verify_file_with_env "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE' || exit 1
  verify_file_with_env "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE' || exit 1
  verify_file_with_env "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE' || exit 1

  echo_green_text 'SUCCESS: Prepared S3 storage - Artifacts'
}

# Prepare secrets for S3 storage - Releases
function prep_s3_releases() {
  echo_red_text 'Preparing S3 storage - Releases...'

  # Ensure we have chmod
  verify_exec "${PHOENIX_CHMOD}" 'PHOENIX_CHMOD' || exit 1

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || exit 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

  # Ensure we have touch
  verify_exec "${PHOENIX_TOUCH}" 'PHOENIX_TOUCH' || exit 1

  # First, check environment variables specified externally (via CI)

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_ACCESS_KEY`
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY+x}" ]] || [[ "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY}" == "" ]] ||
    [[ "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_RELEASES_S3_ACCESS_KEY' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_BUCKET_NAME`
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME+x}" ]] || [[ "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME}" == "" ]] ||
    [[ "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_RELEASES_S3_BUCKET_NAME' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_ENDPOINT`
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ENDPOINT+x}" ]] || [[ "${PHOENIX_CEL_RELEASES_S3_ENDPOINT}" == "" ]] ||
    [[ "${PHOENIX_CEL_RELEASES_S3_ENDPOINT}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_RELEASES_S3_ENDPOINT' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_SECRET_KEY`
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY+x}" ]] || [[ "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY}" == "" ]] ||
    [[ "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_RELEASES_S3_SECRET_KEY' is missing!"
    exit 1
  fi

  # Now, check environment variables specified directly (via `env_ci.sh`/`env_common.sh`)

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE`
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE+x}" ]] || [[ "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" == "" ]] ||
    [[ "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE`
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE+x}" ]] || [[ "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" == "" ]] ||
    [[ "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE`
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE+x}" ]] || [[ "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" == "" ]] ||
    [[ "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE' is missing!"
    exit 1
  fi

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE`
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE+x}" ]] || [[ "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" == "" ]] ||
    [[ "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" == "null" ]]; then
    echo_red_text "ERROR: 'PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE' is missing!"
    exit 1
  fi

  # Create our directories
  "${PHOENIX_MKDIR}" -p $("${PHOENIX_DIRNAME}" "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}")
  "${PHOENIX_MKDIR}" -p $("${PHOENIX_DIRNAME}" "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}")
  "${PHOENIX_MKDIR}" -p $("${PHOENIX_DIRNAME}" "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}")
  "${PHOENIX_MKDIR}" -p $("${PHOENIX_DIRNAME}" "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}")

  # Create the S3 access key file
  "${PHOENIX_TOUCH}" "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}"
  "${PHOENIX_CHMOD}" 600 "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}"
  echo -n "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY}" > "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}"

  # Create the S3 bucket name file
  "${PHOENIX_TOUCH}" "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}"
  "${PHOENIX_CHMOD}" 600 "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}"
  echo -n "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME}" > "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}"

  # Create the S3 endpoint file
  "${PHOENIX_TOUCH}" "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}"
  "${PHOENIX_CHMOD}" 600 "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}"
  echo -n "${PHOENIX_CEL_RELEASES_S3_ENDPOINT}" > "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}"

  # Create the S3 secret key file
  "${PHOENIX_TOUCH}" "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}"
  "${PHOENIX_CHMOD}" 600 "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}"
  echo -n "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY}" > "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}"

  # Ensure nothing went wrong...
  verify_file_with_env "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" 'PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE' || exit 1
  verify_file_with_env "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" 'PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE' || exit 1
  verify_file_with_env "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" 'PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE' || exit 1
  verify_file_with_env "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" 'PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE' || exit 1

  echo_green_text 'SUCCESS: Prepared S3 storage - Releases'
}

# Prepare our secrets...
if [[ "${PHOENIX_CI_PREP_S3_ARTIFACTS}" == 1 ]]; then
  prep_s3_artifacts
elif [[ "${PHOENIX_CI_PREP_S3_RELEASES}" == 1 ]]; then
  prep_s3_releases
fi
