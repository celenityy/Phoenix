#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x

# Set-up our environment
if [[ -z "${PHOENIX_CI+x}" ]]; then
  export PHOENIX_CI=1
fi
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

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

# S3 storage - Artifacts
function prep_s3_artifacts() {
  echo_red_text 'Preparing S3 storage - Artifacts...'

  # First, ensure that environment variables specified externally (from CI) are properly set...

  ## S3 access key
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY+x}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY environment variable is missing! Aborting...'
    exit 1
  fi
  readonly PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY

  ## S3 bucket name
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME+x}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME environment variable is missing! Aborting...'
    exit 1
  fi
  readonly PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME

  ## S3 endpoint
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT+x}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT environment variable is missing! Aborting...'
    exit 1
  fi
  readonly PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT

  ## S3 secret key
  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY+x}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY environment variable is missing! Aborting...'
    exit 1
  fi
  readonly PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY

  # Now, ensure that our S3 file variables (defined at `env_common.sh`, set at `env_ci.sh`) are properly set...

  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [[ "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" == 'null' ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [[ "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" == 'null' ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [[ "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" == 'null' ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [[ "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" == 'null' ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE environment variable has not been specified! Aborting...'
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
  if [[ ! -s "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" ]]; then
    echo_red_text "ERROR: S3 access key file ${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE} is empty!"
    exit 1
  fi

  if [[ ! -s "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" ]]; then
    echo_red_text "ERROR: S3 bucket name file ${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE} is empty!"
    exit 1
  fi

  if [[ ! -s "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" ]]; then
    echo_red_text "ERROR: S3 endpoint file ${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE} is empty!"
    exit 1
  fi

  if [[ ! -s "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" ]]; then
    echo_red_text "ERROR: S3 secret key file ${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE} is empty!"
    exit 1
  fi

  echo_green_text 'SUCCESS: Prepared S3 storage - Artifacts'
}

# S3 storage - Releases
function prep_s3_releases() {
  echo_red_text 'Preparing S3 storage - Releases...'

  # First, ensure that environment variables specified externally (from CI) are properly set...

  ## S3 access key
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY+x}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ACCESS_KEY environment variable is missing! Aborting...'
    exit 1
  fi
  readonly PHOENIX_CEL_RELEASES_S3_ACCESS_KEY

  ## S3 bucket name
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME+x}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_BUCKET_NAME environment variable is missing! Aborting...'
    exit 1
  fi
  readonly PHOENIX_CEL_RELEASES_S3_BUCKET_NAME

  ## S3 endpoint
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ENDPOINT+x}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ENDPOINT environment variable is missing! Aborting...'
    exit 1
  fi
  readonly PHOENIX_CEL_RELEASES_S3_ENDPOINT

  ## S3 secret key
  if [[ -z "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY+x}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_SECRET_KEY environment variable is missing! Aborting...'
    exit 1
  fi
  readonly PHOENIX_CEL_RELEASES_S3_SECRET_KEY

  # Now, ensure that our S3 file variables (defined at `env_common.sh`, set at `env_ci.sh`) are properly set...

  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [[ "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" == 'null' ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [[ "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" == 'null' ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [[ "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" == 'null' ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [[ "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" == 'null' ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE environment variable has not been specified! Aborting...'
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
  if [[ ! -s "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" ]]; then
    echo_red_text "ERROR: S3 access key file ${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE} is empty!"
    exit 1
  fi

  if [[ ! -s "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" ]]; then
    echo_red_text "ERROR: S3 bucket name file ${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE} is empty!"
    exit 1
  fi

  if [[ ! -s "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" ]]; then
    echo_red_text "ERROR: S3 endpoint file ${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE} is empty!"
    exit 1
  fi

  if [[ ! -s "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" ]]; then
    echo_red_text "ERROR: S3 secret key file ${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE} is empty!"
    exit 1
  fi

  echo_green_text 'SUCCESS: Prepared S3 storage - Releases'
}

# Prepare our secrets...
if [[ "${PHOENIX_CI_PREP_S3_ARTIFACTS}" == 1 ]]; then
  prep_s3_artifacts
elif [[ "${PHOENIX_CI_PREP_S3_RELEASES}" == 1 ]]; then
  prep_s3_releases
fi
