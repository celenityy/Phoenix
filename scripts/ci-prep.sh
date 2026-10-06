#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x || exit 1

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

# Create a secret key file
function create_key_file() {
  function print_usage() {
    echo "Usage: create_key_file 'key' 'path/to/key_file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the secret key!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to the key file!'
    print_usage
    exit 1
  fi

  # Ensure we have chmod
  verify_exec "${PHOENIX_CHMOD}" 'PHOENIX_CHMOD' || exit 1

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || exit 1

  # Ensure we have mkdir
  verify_exec "${PHOENIX_MKDIR}" 'PHOENIX_MKDIR' || exit 1

  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

  # Ensure we have touch
  verify_exec "${PHOENIX_TOUCH}" 'PHOENIX_TOUCH' || exit 1

  local -r key="$1"
  local -r key_file="$2"
  local -r key_file_dir=$("${PHOENIX_DIRNAME}" "${key_file}")

  echo_red_text "Creating key file: '${key_file}'..."

  # Ensure the key file doesn't already exist
  "${PHOENIX_RM}" -f "${key_file}"

  # By default, we know the key file creation has not failed...
  local file_creation_failed=0

  # If necessary, create the key file directory
  if [[ ! -d "${key_file_dir}" ]]; then
    "${PHOENIX_MKDIR}" -vp "${key_file_dir}" || local file_creation_failed=1
    local -r created_key_file_dir=1
  else
    local -r created_key_file_dir=0
  fi

  # Create the key file
  "${PHOENIX_TOUCH}" "${key_file}" || local file_creation_failed=1
  "${PHOENIX_CHMOD}" 600 "${key_file}" || local file_creation_failed=1
  echo -n "${key}" > "${key_file}" || local file_creation_failed=1

  # Ensure nothing went wrong...
  if [[ "${file_creation_failed}" != 1 ]]; then
    verify_file "${key_file}" || local file_creation_failed=1
  fi

  if [[ "${file_creation_failed}" == 1 ]]; then
    # If a directory was created just for this key file, remove it
    if [[ "${created_key_file_dir}" == 1 ]]; then
      "${PHOENIX_RM}" -rf "${key_file_dir}"
    fi
    echo_red_text "ERROR: Unable to create key file: '${key_file}'!"
    exit 1
  else
    echo_green_text "SUCCESS: Created key file: '${key_file}'!"
  fi
}

# Prepare secrets for S3 storage
function prep_s3() {
  function print_usage() {
    echo "Usage: prep_s3 's3_access_key' 's3_bucket_name' 's3_endpoint' 's3_secret_key' '/path/to/s3_access_key_file'
      '/path/to/s3_bucket_name_file' '/path/to/s3_endpoint_file' '/path/to/s3_secret_key_file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the S3 access key!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the S3 bucket name!'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the S3 endpoint!'
    print_usage
    exit 1
  fi

  if [[ -z "${4+x}" ]]; then
    echo_red_text 'ERROR: Please specify the S3 secret key!'
    print_usage
    exit 1
  fi

  if [[ -z "${5+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to the S3 access key file!'
    print_usage
    exit 1
  fi

  if [[ -z "${6+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to the S3 bucket name file!'
    print_usage
    exit 1
  fi

  if [[ -z "${7+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to the S3 endpoint file!'
    print_usage
    exit 1
  fi

  if [[ -z "${8+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to the S3 secret key file!'
    print_usage
    exit 1
  fi

  local -r s3_access_key="$1"
  local -r s3_bucket_name="$2"
  local -r s3_endpoint="$3"
  local -r s3_secret_key="$4"
  local -r s3_access_key_file="$5"
  local -r s3_bucket_name_file="$6"
  local -r s3_endpoint_file="$7"
  local -r s3_secret_key_file="$8"

  # Create the S3 access key file
  create_key_file "${s3_access_key}" "${s3_access_key_file}"

  # Create the S3 bucket name file
  create_key_file "${s3_bucket_name}" "${s3_bucket_name_file}"

  # Create the S3 endpoint file
  create_key_file "${s3_endpoint}" "${s3_endpoint_file}"

  # Create the S3 secret key file
  create_key_file "${s3_secret_key}" "${s3_secret_key_file}"
}

# Prepare secrets for S3 storage - Artifacts
function prep_s3_artifacts() {
  echo_red_text 'Preparing S3 storage - Artifacts...'

  # First, check environment variables specified externally (via CI)

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY`
  verify_env "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY}" 'PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY' || exit 1

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME`
  verify_env "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME}" 'PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME' || exit 1

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT`
  verify_env "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT}" 'PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT' || exit 1

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY`
  verify_env "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY}" 'PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY' || exit 1

  # Now, check environment variables specified directly (via `env_ci.sh`/`env_common.sh`)

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE`
  verify_env "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE' || exit 1

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE`
  verify_env "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE' || exit 1

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE`
  verify_env "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE' || exit 1

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE`
  verify_env "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE' || exit 1

  # Prepare our secrets
  prep_s3 "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY}" "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME}" "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT}" "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY}" "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}"

  echo_green_text 'SUCCESS: Prepared S3 storage - Artifacts!'
}

# Prepare secrets for S3 storage - Releases
function prep_s3_releases() {
  echo_red_text 'Preparing S3 storage - Releases...'

  # First, check environment variables specified externally (via CI)

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_ACCESS_KEY`
  verify_env "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY}" 'PHOENIX_CEL_RELEASES_S3_ACCESS_KEY' || exit 1

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_BUCKET_NAME`
  verify_env "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME}" 'PHOENIX_CEL_RELEASES_S3_BUCKET_NAME' || exit 1

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_ENDPOINT`
  verify_env "${PHOENIX_CEL_RELEASES_S3_ENDPOINT}" 'PHOENIX_CEL_RELEASES_S3_ENDPOINT' || exit 1

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_SECRET_KEY`
  verify_env "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY}" 'PHOENIX_CEL_RELEASES_S3_SECRET_KEY' || exit 1

  # Now, check environment variables specified directly (via `env_ci.sh`/`env_common.sh`)

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE`
  verify_env "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" 'PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE' || exit 1

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE`
  verify_env "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" 'PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE' || exit 1

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE`
  verify_env "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" 'PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE' || exit 1

  # Ensure we have `PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE`
  verify_env "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" 'PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE' || exit 1

  # Prepare our secrets
  prep_s3 "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY}" "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME}" "${PHOENIX_CEL_RELEASES_S3_ENDPOINT}" "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY}" "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}"

  echo_green_text 'SUCCESS: Prepared S3 storage - Releases!'
}

# Prepare our secrets...
if [[ "${PHOENIX_CI_PREP_S3_ARTIFACTS}" == 1 ]]; then
  prep_s3_artifacts
elif [[ "${PHOENIX_CI_PREP_S3_RELEASES}" == 1 ]]; then
  prep_s3_releases
fi
