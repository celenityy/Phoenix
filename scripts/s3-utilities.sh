#!/bin/bash

set -euo pipefail

# S3 utility functions

# Ensure this is never ran with xtrace...
set +x

# Set-up our environment
if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  /bin/bash $(dirname $0)/env.sh
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

# Push a file to S3 storage
function push_file() {
  function print_usage() {
    echo "Usage: push_file '/path/to/file' 'path/on/s3' '/path/to/s3_access_key_file' '/path/to/s3_bucket_name_file' '/path/to/s3_endpoint_file'
      '/path/to/s3_secret_key_file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to S3 storage!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the target path on S3 storage for where the file should be uploaded!'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 access key!'
    print_usage
    exit 1
  fi

  if [[ -z "${4+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 bucket name!'
    print_usage
    exit 1
  fi

  if [[ -z "${5+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 endpoint!'
    print_usage
    exit 1
  fi

  if [[ -z "${6+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 secret key!'
    print_usage
    exit 1
  fi

  # Ensure we have basename
  verify_exec "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' || exit 1

  # Ensure we have cat
  verify_exec "${PHOENIX_CAT}" 'PHOENIX_CAT' || exit 1

  # Ensure we have s3cmd
  verify_exec "${PHOENIX_S3CMD}" 'PHOENIX_S3CMD' || exit 1

  # Ensure we have xargs
  verify_exec "${PHOENIX_XARGS}" 'PHOENIX_XARGS' || exit 1

  # Ensure we can source our Python environment
  verify_file "${PHOENIX_PYENV}" || exit 1

  local -r push_file="$1"
  local -r s3_path="$2"
  local -r s3_access_key_file="$3"
  local -r s3_bucket_name_file="$4"
  local -r s3_endpoint_file="$5"
  local -r s3_secret_key_file="$6"
  local -r s3_full_path="${s3_path}/$("${PHOENIX_BASENAME}" "${push_file}")"

  # Ensure our file to push is valid
  verify_file "${push_file}" || exit 1

  # Ensure our secrets are valid
  verify_file "${s3_access_key_file}" || exit 1
  verify_file "${s3_bucket_name_file}" || exit 1
  verify_file "${s3_endpoint_file}" || exit 1
  verify_file "${s3_secret_key_file}" || exit 1

  # Set our MIME type
  case "${push_file}" in
    *.cfg)
      local -r mime_type='text/javascript'
      ;;
    *.js)
      local -r mime_type='text/javascript'
      ;;
    *.json)
      local -r mime_type='application/json'
      ;;
    *.log)
      local -r mime_type='text/plain'
      ;;
    *.md)
      local -r mime_type='text/markdown'
      ;;
    *.png)
      local -r mime_type='image/png'
      ;;
    *.svg)
      local -r mime_type='image/svg+xml'
      ;;
    *.tar.xz)
      local -r mime_type='application/x-gtar'
      ;;
    *.txt)
      local -r mime_type='text/plain'
      ;;
    *.xml)
      local -r mime_type='text/xml'
      ;;
    *.zip)
      local -r mime_type='application/zip'
      ;;
    *)
      echo_red_text "ERROR: Unsupported file type: ${push_file}"
      exit 1
      ;;
  esac

  local -r s3_access_key=$("${PHOENIX_CAT}" "${s3_access_key_file}" | "${PHOENIX_XARGS}")
  local -r s3_bucket_name=$("${PHOENIX_CAT}" "${s3_bucket_name_file}" | "${PHOENIX_XARGS}")
  local -r s3_endpoint=$("${PHOENIX_CAT}" "${s3_endpoint_file}" | "${PHOENIX_XARGS}")
  local -r s3_secret_key=$("${PHOENIX_CAT}" "${s3_secret_key_file}" | "${PHOENIX_XARGS}")

  if [[ "${s3_path}" == 'root' ]]; then
    local -r s3_target_path="s3://${s3_bucket_name}"
  else
    local -r s3_target_path="s3://${s3_bucket_name}/${s3_full_path}"
  fi

  echo_red_text "Pushing ${push_file} to S3..."
  source "${PHOENIX_PYENV}"
  "${PHOENIX_S3CMD}" ${PHOENIX_S3CMD_FLAGS} --mime-type="${mime_type}" put "${push_file}" "${s3_target_path}" \
    --access_key="${s3_access_key}" \
    --secret_key="${s3_secret_key}" \
    --host="${s3_endpoint}" \
    --host-bucket="${s3_endpoint}"
  echo_green_text "SUCCESS: Pushed ${push_file} to S3"
}

# Create and push a SHA512sum for a file to S3 storage
function push_sha512sum() {
  function print_usage() {
    echo "Usage: push_sha512sum '/path/to/file' '/path/to/s3_access_key_file' '/path/to/s3_bucket_name_file' '/path/to/s3_endpoint_file'
      '/path/to/s3_secret_key_file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that a SHA512sum should be created for!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 access key!'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 bucket name!'
    print_usage
    exit 1
  fi

  if [[ -z "${4+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 endpoint!'
    print_usage
    exit 1
  fi

  if [[ -z "${5+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 secret key!'
    print_usage
    exit 1
  fi

  # Ensure we have awk
  verify_exec "${PHOENIX_AWK}" 'PHOENIX_AWK' || exit 1

  # Ensure we have basename
  verify_exec "${PHOENIX_BASENAME}" 'PHOENIX_BASENAME' || exit 1

  # Ensure we have dirname
  verify_exec "${PHOENIX_DIRNAME}" 'PHOENIX_DIRNAME' || exit 1

  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || exit 1

  # Ensure we have shasum
  verify_exec "${PHOENIX_SHASUM}" 'PHOENIX_SHASUM' || exit 1

  local -r sha512sum_file_in="$1"
  local -r sha512sum_s3path="$2"
  local -r s3_access_key_file="$3"
  local -r s3_bucket_name_file="$4"
  local -r s3_endpoint_file="$5"
  local -r s3_secret_key_file="$6"
  local -r sha512sum_file_name=$("${PHOENIX_BASENAME}" "${sha512sum_file_in}")
  local -r sha512sum_file_path=$("${PHOENIX_DIRNAME}" "${sha512sum_file_in}")

  # Ensure our file to create a SHA512sum for is valid
  verify_file "${sha512sum_file_in}" || exit 1

  # Ensure our secrets are valid
  verify_file "${s3_access_key_file}" || exit 1
  verify_file "${s3_bucket_name_file}" || exit 1
  verify_file "${s3_endpoint_file}" || exit 1
  verify_file "${s3_secret_key_file}" || exit 1

  local -r sha512sum_file_out="${sha512sum_file_path}/${sha512sum_file_name}-sha512sum.txt"

  # If there's already a SHA512sum file, remove it
  if [[ -f "${sha512sum_file_out}" ]]; then
    "${PHOENIX_RM}" -f "${sha512sum_file_out}"
  fi

  local -r local_sha512sum=$("${PHOENIX_SHASUM}" -a 512 "${sha512sum_file_in}" | "${PHOENIX_AWK}" '{print $1}')
  echo -n "${local_sha512sum}" > "${sha512sum_file_out}"

  # Push our SHA512sum
  push_file "${sha512sum_file_out}" "${sha512sum_s3path}" "${s3_access_key_file}" "${s3_bucket_name_file}" "${s3_endpoint_file}" "${s3_secret_key_file}"
}

# Create a SHA512sum for and push a file to S3 storage
function push_and_add_sha512sum() {
  function print_usage() {
    echo "Usage: push_and_add_sha512sum '/path/to/file' 'path/on/s3' '/path/to/s3_access_key_file' '/path/to/s3_bucket_name_file'
      '/path/to/s3_endpoint_file' '/path/to/s3_secret_key_file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to S3 storage!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the target path on S3 storage for where the file should be uploaded!'
    print_usage
    exit 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 access key!'
    print_usage
    exit 1
  fi

  if [[ -z "${4+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 bucket name!'
    print_usage
    exit 1
  fi

  if [[ -z "${5+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 endpoint!'
    print_usage
    exit 1
  fi

  if [[ -z "${6+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file containing the S3 secret key!'
    print_usage
    exit 1
  fi

  local -r file_in="$1"
  local -r s3_path_out="$2"
  local -r s3_access_key_file="$3"
  local -r s3_bucket_name_file="$4"
  local -r s3_endpoint_file="$5"
  local -r s3_secret_key_file="$6"

  # Ensure our file to create a SHA512sum for and push is valid
  verify_file "${file_in}" || exit 1

  # Ensure our secrets are valid
  verify_file "${s3_access_key_file}" || exit 1
  verify_file "${s3_bucket_name_file}" || exit 1
  verify_file "${s3_endpoint_file}" || exit 1
  verify_file "${s3_secret_key_file}" || exit 1

  # Push our file to S3 storage
  push_file "${file_in}" "${s3_path_out}" "${s3_access_key_file}" "${s3_bucket_name_file}" "${s3_endpoint_file}" "${s3_secret_key_file}"

  # Create and push a SHA512sum for our file to S3 storage
  push_sha512sum "${file_in}" "${s3_path_out}" "${s3_access_key_file}" "${s3_bucket_name_file}" "${s3_endpoint_file}" "${s3_secret_key_file}"
}
