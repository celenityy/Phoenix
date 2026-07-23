#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x

# Set-up our environment
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

if [[ -z "${PHOENIX_FROM_PUSH+x}" ]]; then
  echo_red_text 'ERROR: Do not call push-phoenix.sh directly. Instead, use push.sh.' >&1
  exit 1
fi

if [[ -z "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" ]]; then
  echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE environment variable is missing! Aborting...'
  exit 1
fi

if [[ ! -f "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" ]]; then
  echo_red_text "ERROR: S3 access key file not found! (${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE})"
  echo_green_text "Please ensure the PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE environment variable is set to the correct path in which the key file is located."
  echo_red_text "Aborting..."
  exit 1
fi

if [[ ! -s "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" ]]; then
  echo_red_text "ERROR: S3 access key file ${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE} is empty!"
  exit 1
fi

if [[ -z "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" ]]; then
  echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE environment variable is missing! Aborting...'
  exit 1
fi

if [[ ! -f "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" ]]; then
  echo_red_text "ERROR: S3 bucket name file not found! (${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE})"
  echo_green_text "Please ensure the PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE environment variable is set to the correct path in which the bucket name file is located."
  echo_red_text "Aborting..."
  exit 1
fi

if [[ ! -s "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" ]]; then
  echo_red_text "ERROR: S3 bucket name file ${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE} is empty!"
  exit 1
fi

if [[ -z "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" ]]; then
  echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE environment variable is missing! Aborting...'
  exit 1
fi

if [[ ! -f "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" ]]; then
  echo_red_text "ERROR: S3 endpoint file not found! (${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE})"
  echo_green_text "Please ensure the PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE environment variable is set to the correct path in which the endpoint file is located."
  echo_red_text "Aborting..."
  exit 1
fi

if [[ ! -s "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" ]]; then
  echo_red_text "ERROR: S3 bucket name file ${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE} is empty!"
  exit 1
fi

if [[ -z "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" ]]; then
  echo_red_text 'ERROR: The PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE environment variable is missing! Aborting...'
  exit 1
fi

if [[ ! -f "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" ]]; then
  echo_red_text "ERROR: S3 secret key file not found! (${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE})"
  echo_green_text "Please ensure the PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE environment variable is set to the correct path in which the key file is located."
  echo_red_text "Aborting..."
  exit 1
fi

if [[ ! -s "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" ]]; then
  echo_red_text "ERROR: S3 secret key file ${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE} is empty!"
  exit 1
fi

readonly target="$1"

# Set-up target parameters
PHOENIX_PUSH_ANDROID=0
PHOENIX_PUSH_LINUX=0
PHOENIX_PUSH_LINUX_FLATPAK=0
PHOENIX_PUSH_OSX=0
PHOENIX_PUSH_OSX_INTEL=0
PHOENIX_PUSH_UNIVERSAL=0
PHOENIX_PUSH_WINDOWS=0

if [[ "${target}" == 'android' ]]; then
  # Push Phoenix for Android
  PHOENIX_PUSH_ANDROID=1
elif [[ "${target}" == 'linux' ]]; then
  # Push Phoenix for Linux (non-Flatpak)
  PHOENIX_PUSH_LINUX=1
elif [[ "${target}" == 'linux-flatpak' ]]; then
  # Push Phoenix for Linux (Flatpak)
  PHOENIX_PUSH_LINUX_FLATPAK=1
elif [[ "${target}" == 'osx' ]]; then
  # Push Phoenix for OS X (Silicon)
  PHOENIX_PUSH_OSX=1
elif [[ "${target}" == 'osx-intel' ]]; then
  # Push Phoenix for OS X (Intel)
  PHOENIX_PUSH_OSX_INTEL=1
elif [[ "${target}" == 'universal' ]]; then
  # Push Phoenix (Universal)
  PHOENIX_PUSH_UNIVERSAL=1
elif [[ "${target}" == 'windows' ]]; then
  # Push Phoenix for Windows
  PHOENIX_PUSH_WINDOWS=1
elif [[ "${target}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just push everything
  PHOENIX_PUSH_ANDROID=1
  PHOENIX_PUSH_LINUX=1
  PHOENIX_PUSH_LINUX_FLATPAK=1
  PHOENIX_PUSH_OSX=1
  PHOENIX_PUSH_OSX_INTEL=1
  PHOENIX_PUSH_UNIVERSAL=1
  PHOENIX_PUSH_WINDOWS=1
else
  echo_red_text "ERROR: Invalid target: ${target}\n You must enter one of the following:"
  echo 'All:                              all (Default)'
  echo 'Android:                          android'
  echo 'Linux (non-Flatpak):              linux'
  echo 'Linux (Flatpak):                  linux-flatpak'
  echo 'OS X (Silicon):                   osx'
  echo 'OS X (Intel):                     osx-intel'
  echo 'Universal:                        universal'
  echo 'Windows:                          windows'
  exit 1
fi

readonly PHOENIX_PUSH_ANDROID
readonly PHOENIX_PUSH_LINUX
readonly PHOENIX_PUSH_LINUX_FLATPAK
readonly PHOENIX_PUSH_OSX
readonly PHOENIX_PUSH_OSX_INTEL
readonly PHOENIX_PUSH_UNIVERSAL
readonly PHOENIX_PUSH_WINDOWS

# Include version info
source "${PHOENIX_VERSIONS}"

# Set timezone to UTC for consistency
unset TZ
export TZ="UTC"

# Verifies that a file exists and is not empty
function verify_file() {
  function print_usage() {
    echo "Usage: verify_file '/path/to/file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file to verify'
    print_usage
    exit 1
  fi

  local readonly file_to_verify="$1"

  if [[ ! -f "${file_to_verify}" ]]; then
    echo_red_text "ERROR: File ${file_to_verify} does not exist!"
    exit 1
  fi

  if [[ ! -s "${file_to_verify}" ]]; then
    echo_red_text "ERROR: File ${file_to_verify} is empty!"
    exit 1
  fi
}

# Pushes a file to S3
function push_file() {
  function print_usage() {
    echo "Usage: push_file '/path/to/file' 'path/on/s3'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to S3 storage'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the target path on S3 storage for where the file should be uploaded'
    print_usage
    exit 1
  fi

  local readonly push_file="$1"
  local readonly s3_path="$2"
  local readonly s3_full_path="${s3_path}/$("${PHOENIX_BASENAME}" "${push_file}")"

  # Ensure our file to push is valid
  verify_file "${push_file}"

  # Set our MIME type
  case "${push_file}" in
  *.cfg)
    local readonly mime_type='text/javascript'
    ;;
  *.js)
    local readonly mime_type='text/javascript'
    ;;
  *.tar.xz)
    local readonly mime_type='application/x-gtar'
    ;;
  *.txt)
    local readonly mime_type='text/plain'
    ;;
  *.zip)
    local readonly mime_type='application/zip'
    ;;
  *)
    echo_red_text "ERROR: Unsupported file type: ${push_file}"
    exit 1
    ;;
  esac

  local readonly s3_access_key=$("${PHOENIX_CAT}" "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" | "${PHOENIX_XARGS}")
  local readonly s3_bucket_name=$("${PHOENIX_CAT}" "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" | "${PHOENIX_XARGS}")
  local readonly s3_endpoint=$("${PHOENIX_CAT}" "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" | "${PHOENIX_XARGS}")
  local readonly s3_secret_key=$("${PHOENIX_CAT}" "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" | "${PHOENIX_XARGS}")

  if [[ "${s3_path}" == 'root' ]]; then
    local readonly s3_target_path="s3://${s3_bucket_name}"
  else
    local readonly s3_target_path="s3://${s3_bucket_name}/${s3_full_path}"
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

# Creates and pushes a SHA512sum for a file to S3
function add_sha512sum() {
  function print_usage() {
    echo "Usage: add_sha512sum '/path/to/file'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that a SHA512sum should be created for'
    print_usage
    exit 1
  fi

  local readonly sha512sum_file_in="$1"
  local readonly sha512sum_file_name=$("${PHOENIX_BASENAME}" "${sha512sum_file_in}")
  local readonly sha512sum_file_path=$("${PHOENIX_DIRNAME}" "${sha512sum_file_in}")

  if [[ -z "${2+x}" ]]; then
    local readonly sha512sum_s3path=$("${PHOENIX_BASENAME}" "${sha512sum_file_path}" | "${PHOENIX_AWK}" '{print tolower($0)}')
  else
    local readonly sha512sum_s3path="$2"
  fi

  # Ensure our file to create a SHA512sum for is valid
  verify_file "${sha512sum_file_in}"

  local readonly sha512sum_file_out="${sha512sum_file_path}/${sha512sum_file_name}-sha512sum.txt"

  # If there's already a SHA512sum file, remove it
  if [[ -f "${sha512sum_file_out}" ]]; then
    "${PHOENIX_RM}" -f "${sha512sum_file_out}"
  fi

  local readonly local_sha512sum=$("${PHOENIX_SHA512SUM}" "${sha512sum_file_in}" | "${PHOENIX_AWK}" '{print $1}')
  echo -n "${local_sha512sum}" >"${sha512sum_file_out}"

  push_file "${sha512sum_file_out}" "${sha512sum_s3path}"
}

# Creates a SHA512sum for and pushes a file to S3
function push_and_add_sha512sum() {
  function print_usage() {
    echo "Usage: push_and_add_sha512sum '/path/to/file' 'path/on/s3'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to S3 storage'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the target path on S3 storage for where the file should be uploaded'
    print_usage
    exit 1
  fi

  local readonly file_in="$1"
  local readonly s3_path_out="$2"

  # Ensure our file to create a SHA512sum for and push is valid
  verify_file "${file_in}"

  # Push our file to S3
  push_file "${file_in}" "${s3_path_out}"

  # Create and push a SHA512sum for our file to S3
  add_sha512sum "${file_in}" "${s3_path_out}"
}

# Push a universal Phoenix configuration file
function push_phoenix_universal() {
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/universal/phoenix-${PHOENIX_VERSION}-universal.cfg" "phoenix/releases/${PHOENIX_VERSION}/universal"

  # Ensure the latest version can always be downloaded from https://releases.celenity.dev/phoenix/releases/latest/{phoenix_platform}/phoenix-latest-{phoenix_platform}.cfg
  ## (Ex. for convenience/packaging)
  "${PHOENIX_CP}" -f "${PHOENIX_OUTPUTS}/universal/phoenix-${PHOENIX_VERSION}-universal.cfg" "${PHOENIX_OUTPUTS}/universal/phoenix-latest-universal.cfg"
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/universal/phoenix-latest-universal.cfg" "phoenix/releases/latest/universal"
}

# Push Phoenix for a desired platform
function push_phoenix() {
  function print_usage() {
    echo "Usage: push_phoenix 'platform'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the platform you wou would like to push Phoenix for'
    print_usage
    exit 1
  fi

  local readonly phoenix_platform="$1"

  # Universal logic is handled elsewhere...
  if [[ "${phoenix_platform}" == 'universal' ]]; then
    push_phoenix_universal
    return 0
  fi

  # Set our archive type
  if [[ "${phoenix_platform}" == 'windows' ]]; then
    local readonly phoenix_archive_type='zip'
  else
    local readonly phoenix_archive_type='tar.xz'
  fi

  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.${phoenix_archive_type}" "phoenix/releases/${PHOENIX_VERSION}/${phoenix_platform}"

  # Ensure the latest version can always be downloaded from https://releases.celenity.dev/phoenix/releases/latest/{phoenix_platform}/phoenix-latest-{phoenix_platform}.${phoenix_archive_type}
  ## (Ex. for convenience/packaging)
  "${PHOENIX_CP}" -f "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.${phoenix_archive_type}" "${PHOENIX_OUTPUTS}/phoenix-latest-${phoenix_platform}.${phoenix_archive_type}"
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-latest-${phoenix_platform}.${phoenix_archive_type}" "phoenix/releases/latest/${phoenix_platform}"

  # For Android, also push phoenix.js and phoenix-extended.js directly
  if [[ "${phoenix_platform}" == 'android' ]]; then
    push_and_add_sha512sum "${PHOENIX_OUTPUTS}/${phoenix_platform}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.js" "phoenix/releases/${PHOENIX_VERSION}/${phoenix_platform}"
    push_and_add_sha512sum "${PHOENIX_OUTPUTS}/${phoenix_platform}/phoenix-extended-${PHOENIX_VERSION}-${phoenix_platform}.js" "phoenix/releases/${PHOENIX_VERSION}/${phoenix_platform}"

    # Ensure the latest version can always be downloaded from https://releases.celenity.dev/phoenix/releases/latest/{phoenix_platform}/phoenix-latest-{phoenix_platform}.js
    ## (and https://releases.celenity.dev/phoenix/releases/latest/{phoenix_platform}/phoenix-extended-latest-{phoenix_platform}.js)
    ## (Ex. for convenience/packaging)
    "${PHOENIX_CP}" -f "${PHOENIX_OUTPUTS}/${phoenix_platform}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.js" "${PHOENIX_OUTPUTS}/${phoenix_platform}/phoenix-latest-${phoenix_platform}.js"
    push_and_add_sha512sum "${PHOENIX_OUTPUTS}/${phoenix_platform}/phoenix-latest-${phoenix_platform}.js" "phoenix/releases/latest/${phoenix_platform}"

    "${PHOENIX_CP}" -f "${PHOENIX_OUTPUTS}/${phoenix_platform}/phoenix-extended-${PHOENIX_VERSION}-${phoenix_platform}.js" "${PHOENIX_OUTPUTS}/${phoenix_platform}/phoenix-extended-latest-${phoenix_platform}.js"
    push_and_add_sha512sum "${PHOENIX_OUTPUTS}/${phoenix_platform}/phoenix-extended-latest-${phoenix_platform}.js" "phoenix/releases/latest/${phoenix_platform}"
  fi
}

if [[ "${PHOENIX_PUSH_ANDROID}" == 1 ]]; then
  push_phoenix 'android'
fi

if [[ "${PHOENIX_PUSH_LINUX}" == 1 ]]; then
  push_phoenix 'linux'
fi

if [[ "${PHOENIX_PUSH_LINUX_FLATPAK}" == 1 ]]; then
  push_phoenix 'linux-flatpak'
fi

if [[ "${PHOENIX_PUSH_OSX}" == 1 ]]; then
  push_phoenix 'osx'
fi

if [[ "${PHOENIX_PUSH_OSX_INTEL}" == 1 ]]; then
  push_phoenix 'osx-intel'
fi

if [[ "${PHOENIX_PUSH_UNIVERSAL}" == 1 ]]; then
  push_phoenix 'universal'
fi

if [[ "${PHOENIX_PUSH_WINDOWS}" == 1 ]]; then
  push_phoenix 'windows'
fi
