#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x || exit 1

# Set-up our environment
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${PHOENIX_UTILS}" || exit 1

# Include S3 utilities
source "${PHOENIX_S3_UTILS}" || exit 1

if [[ -z "${PHOENIX_FROM_AR_UP+x}" ]]; then
  echo_red_text "ERROR: Do not call 'ci-upload-artifacts-phoenix.sh' directly! Instead, use 'ci-upload-artifacts.sh'." >&1
  exit 1
fi

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: $0 should only be called from CI!"
  exit 1
fi

if [[ -z "${PHOENIX_CI_ID+x}" ]]; then
  echo_red_text "ERROR: Missing CI ID! Please set 'PHOENIX_CI_ID'."
  exit 1
fi

# Include version info
source "${PHOENIX_VERSIONS}" || exit 1

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

# Target S3 path
readonly PHOENIX_S3_PATH="phoenix/${PHOENIX_CI_ID}"

# Push a file with a SHA512sum to S3 storage
function push_to_s3() {
  function print_usage() {
    echo "Usage: push_to_s3 '/path/to/file' 'path/on/s3'"
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

  local -r push_file="$1"
  local -r s3_path="$2"

  local -r s3_access_key_file="${PHOENIX_CEL_ARTIFACTS_S3_ACCESS_KEY_FILE}"
  local -r s3_bucket_name_file="${PHOENIX_CEL_ARTIFACTS_S3_BUCKET_NAME_FILE}"
  local -r s3_endpoint_file="${PHOENIX_CEL_ARTIFACTS_S3_ENDPOINT_FILE}"
  local -r s3_secret_key_file="${PHOENIX_CEL_ARTIFACTS_S3_SECRET_KEY_FILE}"

  # Ensure our file to push is valid
  verify_file "${push_file}" || exit 1

  # Create and push a SHA512sum for our file to S3 storage
  push_and_add_sha512sum "${push_file}" "${s3_path}" "${s3_access_key_file}" "${s3_bucket_name_file}" "${s3_endpoint_file}" "${s3_secret_key_file}"
}

# phoenix-{PHOENIX_VERSION}-android.tar.xz
if [[ "${PHOENIX_AR_UP_ANDROID_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-android.tar.xz" "${PHOENIX_S3_PATH}"
fi

# phoenix-{PHOENIX_VERSION}-android.js
if [[ "${PHOENIX_AR_UP_ANDROID_JS}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/android/phoenix-${PHOENIX_VERSION}-android.js" "${PHOENIX_S3_PATH}"
fi

# phoenix-extended-{PHOENIX_VERSION}-android.js
if [[ "${PHOENIX_AR_UP_ANDROID_JS_EXTENDED}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/android/phoenix-extended-${PHOENIX_VERSION}-android.js" "${PHOENIX_S3_PATH}"
fi

# phoenix-{PHOENIX_VERSION}-linux.tar.xz
if [[ "${PHOENIX_AR_UP_LINUX_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-linux.tar.xz" "${PHOENIX_S3_PATH}"
fi

# phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
if [[ "${PHOENIX_AR_UP_LINUX_FLATPAK_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-linux-flatpak.tar.xz" "${PHOENIX_S3_PATH}"
fi

# phoenix-{PHOENIX_VERSION}-osx.tar.xz
if [[ "${PHOENIX_AR_UP_OSX_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-osx.tar.xz" "${PHOENIX_S3_PATH}"
fi

# phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
if [[ "${PHOENIX_AR_UP_OSX_INTEL_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-osx-intel.tar.xz" "${PHOENIX_S3_PATH}"
fi

# phoenix-{PHOENIX_VERSION}-windows.zip
if [[ "${PHOENIX_AR_UP_WINDOWS_ARCHIVE}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-windows.zip" "${PHOENIX_S3_PATH}"
fi

# phoenix-{PHOENIX_VERSION}-universal.cfg
if [[ "${PHOENIX_AR_UP_UNIVERSAL_CFG}" == 1 ]]; then
  push_to_s3 "${PHOENIX_OUTPUTS}/phoenix-${PHOENIX_VERSION}-universal.cfg" "${PHOENIX_S3_PATH}"
fi
