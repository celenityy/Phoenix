#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x

# Set-up our environment
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

if [[ -z "${PHOENIX_FROM_AR_UP+x}" ]]; then
  echo_red_text 'ERROR: Do not call ci-upload-artifacts-phoenix.sh directly. Instead, use ci-upload-artifacts.sh.' >&1
  exit 1
fi

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: $0 should only be called from CI!"
  exit 1
fi

if [[ -z "${PHOENIX_CI_ID+x}" ]]; then
  echo_red_text 'ERROR: Missing CI ID! Please set PHOENIX_CI_ID.'
  exit 1
fi

# Include version info
source "${PHOENIX_VERSIONS}"

# Verify secrets
verify_file_with_env "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE' || exit 1
verify_file_with_env "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE' || exit 1
verify_file_with_env "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE' || exit 1
verify_file_with_env "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" 'PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE' || exit 1

readonly up_artifact="$1"

# Set-up target parameters
PHOENIX_AR_UP_ANDROID_ARCHIVE=0
PHOENIX_AR_UP_ANDROID_JS=0
PHOENIX_AR_UP_ANDROID_JS_EXTENDED=0
PHOENIX_AR_UP_LINUX_ARCHIVE=0
PHOENIX_AR_UP_LINUX_FLATPAK_ARCHIVE=0
PHOENIX_AR_UP_OSX_ARCHIVE=0
PHOENIX_AR_UP_OSX_INTEL_ARCHIVE=0
PHOENIX_AR_UP_WINDOWS_ARCHIVE=0
PHOENIX_AR_UP_UNIVERSAL_CFG=0

if [[ "${up_artifact}" == 'android-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-android.tar.xz
  PHOENIX_AR_UP_ANDROID_ARCHIVE=1
elif [[ "${up_artifact}" == 'android-js' ]]; then
  # phoenix-{PHOENIX_VERSION}-android.js
  PHOENIX_AR_UP_ANDROID_JS=1
elif [[ "${up_artifact}" == 'android-js-extended' ]]; then
  # phoenix-extended-{PHOENIX_VERSION}-android.js
  PHOENIX_AR_UP_ANDROID_JS_EXTENDED=1
elif [[ "${up_artifact}" == 'linux-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-linux.tar.xz
  PHOENIX_AR_UP_LINUX_ARCHIVE=1
elif [[ "${up_artifact}" == 'linux-flatpak-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
  PHOENIX_AR_UP_LINUX_FLATPAK_ARCHIVE=1
elif [[ "${up_artifact}" == 'osx-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-osx.tar.xz
  PHOENIX_AR_UP_OSX_ARCHIVE=1
elif [[ "${up_artifact}" == 'osx-intel-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
  PHOENIX_AR_UP_OSX_INTEL_ARCHIVE=1
elif [[ "${up_artifact}" == 'windows-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-windows.zip
  PHOENIX_AR_UP_WINDOWS_ARCHIVE=1
elif [[ "${up_artifact}" == 'universal-cfg' ]]; then
  # phoenix-{PHOENIX_VERSION}-universal.cfg
  PHOENIX_AR_UP_UNIVERSAL_CFG=1
elif [[ "${up_artifact}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just download everything
  PHOENIX_AR_UP_ANDROID_ARCHIVE=1
  PHOENIX_AR_UP_ANDROID_JS=1
  PHOENIX_AR_UP_ANDROID_JS_EXTENDED=1
  PHOENIX_AR_UP_LINUX_ARCHIVE=1
  PHOENIX_AR_UP_LINUX_FLATPAK_ARCHIVE=1
  PHOENIX_AR_UP_OSX_ARCHIVE=1
  PHOENIX_AR_UP_OSX_INTEL_ARCHIVE=1
  PHOENIX_AR_UP_WINDOWS_ARCHIVE=1
  PHOENIX_AR_UP_UNIVERSAL_CFG=1
else
  echo_red_text "ERROR: Invalid target: ${up_artifact}\n You must enter one of the following:"
  echo 'All:                      all (Default)'
  echo 'Android archive:          android-archive'
  echo 'Android .js:              android-js'
  echo 'Android .js - Extended:   android-js-extended'
  echo 'Linux archive:            linux-archive'
  echo 'Linux (Flatpak) archive:  linux-flatpak-archive'
  echo 'OS X archive:             osx-archive'
  echo 'OS X (Intel) archive:     osx-intel-archive'
  echo 'Windows archive:          windows-archive'
  echo 'Universal .cfg:           universal-cfg'
  exit 1
fi
readonly PHOENIX_AR_UP_ANDROID_ARCHIVE
readonly PHOENIX_AR_UP_ANDROID_JS
readonly PHOENIX_AR_UP_ANDROID_JS_EXTENDED
readonly PHOENIX_AR_UP_LINUX_ARCHIVE
readonly PHOENIX_AR_UP_LINUX_FLATPAK_ARCHIVE
readonly PHOENIX_AR_UP_OSX_ARCHIVE
readonly PHOENIX_AR_UP_OSX_INTEL_ARCHIVE
readonly PHOENIX_AR_UP_WINDOWS_ARCHIVE
readonly PHOENIX_AR_UP_UNIVERSAL_CFG

# Constants

# Target project
readonly PHOENIX_CEL_S3_PROJECT='phoenix'

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

  local -r push_file="$1"
  local -r s3_path="$2"
  local -r s3_full_path="${s3_path}/$("${PHOENIX_BASENAME}" "${push_file}")"

  # Ensure our file to push is valid
  verify_file "${push_file}" || exit 1

  # Set our MIME type
  case "${push_file}" in
    *.cfg)
      local -r mime_type='text/javascript'
      ;;
    *.js)
      local -r mime_type='text/javascript'
      ;;
    *.log)
      local -r mime_type='text/plain'
      ;;
    *.tar.xz)
      local -r mime_type='application/x-gtar'
      ;;
    *.txt)
      local -r mime_type='text/plain'
      ;;
    *.zip)
      local -r mime_type='application/zip'
      ;;
    *)
      echo_red_text "ERROR: Unsupported file type: ${push_file}"
      exit 1
      ;;
  esac

  local -r s3_access_key=$("${PHOENIX_CAT}" "${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}" | "${PHOENIX_XARGS}")
  local -r s3_bucket_name=$("${PHOENIX_CAT}" "${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}" | "${PHOENIX_XARGS}")
  local -r s3_endpoint=$("${PHOENIX_CAT}" "${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}" | "${PHOENIX_XARGS}")
  local -r s3_secret_key=$("${PHOENIX_CAT}" "${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}" | "${PHOENIX_XARGS}")

  if [[ "${s3_path}" == 'root' ]]; then
    local -r s3_target_path="s3://${s3_bucket_name}/${PHOENIX_CEL_S3_PROJECT}"
  else
    local -r s3_target_path="s3://${s3_bucket_name}/${PHOENIX_CEL_S3_PROJECT}/${s3_full_path}"
  fi

  echo_red_text "Uploading ${push_file} to S3..."
  source "${PHOENIX_PYENV}"
  "${PHOENIX_S3CMD}" ${PHOENIX_S3CMD_FLAGS} --mime-type="${mime_type}" put "${push_file}" "${s3_target_path}" \
    --access_key="${s3_access_key}" \
    --secret_key="${s3_secret_key}" \
    --host="${s3_endpoint}" \
    --host-bucket="${s3_endpoint}"
  echo_green_text "SUCCESS: Uploaded ${push_file} to S3"
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

  local -r sha512sum_file_in="$1"
  local -r sha512sum_file_name=$("${PHOENIX_BASENAME}" "${sha512sum_file_in}")
  local -r sha512sum_file_path=$("${PHOENIX_DIRNAME}" "${sha512sum_file_in}")

  if [[ -z "${2+x}" ]]; then
    local -r sha512sum_s3path=$("${PHOENIX_BASENAME}" "${sha512sum_file_path}" | "${PHOENIX_AWK}" '{print tolower($0)}')
  else
    local -r sha512sum_s3path="$2"
  fi

  # Ensure our file to create a SHA512sum for is valid
  verify_file "${sha512sum_file_in}" || exit 1

  local -r sha512sum_file_out="${sha512sum_file_path}/${sha512sum_file_name}-sha512sum.txt"

  # If there's already a SHA512sum file, remove it
  if [[ -f "${sha512sum_file_out}" ]]; then
    "${PHOENIX_RM}" -f "${sha512sum_file_out}"
  fi

  local -r local_sha512sum=$("${PHOENIX_SHASUM}" -a 512 "${sha512sum_file_in}" | "${PHOENIX_AWK}" '{print $1}')
  echo -n "${local_sha512sum}" > "${sha512sum_file_out}"

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

  local -r file_in="$1"
  local -r s3_path_out="$2"

  # Ensure our file to create a SHA512sum for and push is valid
  verify_file "${file_in}" || exit 1

  # Push our file to S3
  push_file "${file_in}" "${s3_path_out}"

  # Create and push a SHA512sum for our file to S3
  add_sha512sum "${file_in}" "${s3_path_out}"
}

# phoenix-{PHOENIX_VERSION}-android.tar.xz
if [[ "${PHOENIX_AR_UP_ANDROID_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-android.tar.xz" "${PHOENIX_CI_ID}"
fi

# phoenix-{PHOENIX_VERSION}-android.js
if [[ "${PHOENIX_AR_UP_ANDROID_JS}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/android/phoenix-${PHOENIX_VERSION}-android.js" "${PHOENIX_CI_ID}"
fi

# phoenix-extended-{PHOENIX_VERSION}-android.js
if [[ "${PHOENIX_AR_UP_ANDROID_JS_EXTENDED}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/android/phoenix-extended-${PHOENIX_VERSION}-android.js" "${PHOENIX_CI_ID}"
fi

# phoenix-{PHOENIX_VERSION}-linux.tar.xz
if [[ "${PHOENIX_AR_UP_LINUX_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-linux.tar.xz" "${PHOENIX_CI_ID}"
fi

# phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
if [[ "${PHOENIX_AR_UP_LINUX_FLATPAK_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-linux-flatpak.tar.xz" "${PHOENIX_CI_ID}"
fi

# phoenix-{PHOENIX_VERSION}-osx.tar.xz
if [[ "${PHOENIX_AR_UP_OSX_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-osx.tar.xz" "${PHOENIX_CI_ID}"
fi

# phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
if [[ "${PHOENIX_AR_UP_OSX_INTEL_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-osx-intel.tar.xz" "${PHOENIX_CI_ID}"
fi

# phoenix-{PHOENIX_VERSION}-windows.zip
if [[ "${PHOENIX_AR_UP_WINDOWS_ARCHIVE}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-windows.zip" "${PHOENIX_CI_ID}"
fi

# phoenix-{PHOENIX_VERSION}-universal.cfg
if [[ "${PHOENIX_AR_UP_UNIVERSAL_CFG}" == 1 ]]; then
  push_and_add_sha512sum "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-universal.cfg" "${PHOENIX_CI_ID}"
fi
