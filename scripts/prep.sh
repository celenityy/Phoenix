#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  bash -x $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

# S3 storage
function prep_s3() {
  echo_red_text 'Preparing S3 storage...'

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

  if [ "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" == 'null' ]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [ "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" == 'null' ]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [ "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" == 'null' ]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  if [[ -z "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" ]]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE environment variable is missing! Aborting...'
    exit 1
  fi

  if [ "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" == 'null' ]; then
    echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE environment variable has not been specified! Aborting...'
    exit 1
  fi

  # Create our directories
  mkdir -p $(dirname "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}")
  mkdir -p $(dirname "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}")
  mkdir -p $(dirname "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}")
  mkdir -p $(dirname "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}")

  # Create the S3 access key file
  touch "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}"
  chmod 600 "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}"
  echo -n "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY}" >"${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}"

  # Create the S3 bucket name file
  touch "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}"
  chmod 600 "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}"
  echo -n "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME}" >"${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}"

  # Create the S3 endpoint file
  touch "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}"
  chmod 600 "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}"
  echo -n "${PHOENIX_CEL_RELEASES_S3_ENDPOINT}" >"${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}"

  # Create the S3 secret key file
  touch "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}"
  chmod 600 "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}"
  echo -n "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY}" >"${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}"

  # Ensure nothing went wrong...
  if ! [[ -s "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" ]]; then
    echo_red_text "ERROR: S3 access key file ${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE} is empty!"
    exit 1
  fi

  if ! [[ -s "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" ]]; then
    echo_red_text "ERROR: S3 bucket name file ${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE} is empty!"
    exit 1
  fi

  if ! [[ -s "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" ]]; then
    echo_red_text "ERROR: S3 endpoint file ${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE} is empty!"
    exit 1
  fi

  if ! [[ -s "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" ]]; then
    echo_red_text "ERROR: S3 secret key file ${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE} is empty!"
    exit 1
  fi

  echo_green_text 'SUCCESS: Prepared S3 storage'
}

# Prepare our secrets...
prep_s3
