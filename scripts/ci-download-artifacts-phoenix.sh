#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_CI+x}" ]]; then
  export PHOENIX_CI=1
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

# Include version info
source "${PHOENIX_VERSIONS}"

if [[ -z "${PHOENIX_FROM_AR_DOWN+x}" ]]; then
  echo_red_text 'ERROR: Do not call ci-download-artifacts-phoenix.sh directly. Instead, use ci-download-artifacts.sh.' >&1
  exit 1
fi

if [[ -z "${PHOENIX_CI_ID+x}" ]]; then
  echo_red_text 'ERROR: Missing CI ID! Please set PHOENIX_CI_ID.'
  exit 1
fi

# Set verbosity
if [[ "${PHOENIX_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

readonly down_artifact="$1"

# Set-up target parameters
PHOENIX_AR_DOWN_ANDROID_ARCHIVE=0
PHOENIX_AR_DOWN_ANDROID_JS=0
PHOENIX_AR_DOWN_ANDROID_JS_EXTENDED=0
PHOENIX_AR_DOWN_LINUX_ARCHIVE=0
PHOENIX_AR_DOWN_LINUX_FLATPAK_ARCHIVE=0
PHOENIX_AR_DOWN_OSX_ARCHIVE=0
PHOENIX_AR_DOWN_OSX_INTEL_ARCHIVE=0
PHOENIX_AR_DOWN_WINDOWS_ARCHIVE=0
PHOENIX_AR_DOWN_UNIVERSAL_CFG=0

if [[ "${down_artifact}" == 'android-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-android.tar.xz
  PHOENIX_AR_DOWN_ANDROID_ARCHIVE=1
elif [[ "${down_artifact}" == 'android-js' ]]; then
  # phoenix-{PHOENIX_VERSION}-android.js
  PHOENIX_AR_DOWN_ANDROID_JS=1
elif [[ "${down_artifact}" == 'android-js-extended' ]]; then
  # phoenix-extended-{PHOENIX_VERSION}-android.js
  PHOENIX_AR_DOWN_ANDROID_JS_EXTENDED=1
elif [[ "${down_artifact}" == 'linux-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-linux.tar.xz
  PHOENIX_AR_DOWN_LINUX_ARCHIVE=1
elif [[ "${down_artifact}" == 'linux-flatpak-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
  PHOENIX_AR_DOWN_LINUX_FLATPAK_ARCHIVE=1
elif [[ "${down_artifact}" == 'osx-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-osx.tar.xz
  PHOENIX_AR_DOWN_OSX_ARCHIVE=1
elif [[ "${down_artifact}" == 'osx-intel-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
  PHOENIX_AR_DOWN_OSX_INTEL_ARCHIVE=1
elif [[ "${down_artifact}" == 'windows-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-windows.zip
  PHOENIX_AR_DOWN_WINDOWS_ARCHIVE=1
elif [[ "${down_artifact}" == 'universal-cfg' ]]; then
  # phoenix-{PHOENIX_VERSION}-universal.cfg
  PHOENIX_AR_DOWN_UNIVERSAL_CFG=1
elif [[ "${down_artifact}" == 'all' ]]; then
  # If no argument is specified (or argument is set to "all"), just download everything
  PHOENIX_AR_DOWN_ANDROID_ARCHIVE=1
  PHOENIX_AR_DOWN_ANDROID_JS=1
  PHOENIX_AR_DOWN_ANDROID_JS_EXTENDED=1
  PHOENIX_AR_DOWN_LINUX_ARCHIVE=1
  PHOENIX_AR_DOWN_LINUX_FLATPAK_ARCHIVE=1
  PHOENIX_AR_DOWN_OSX_ARCHIVE=1
  PHOENIX_AR_DOWN_OSX_INTEL_ARCHIVE=1
  PHOENIX_AR_DOWN_WINDOWS_ARCHIVE=1
  PHOENIX_AR_DOWN_UNIVERSAL_CFG=1
else
  echo_red_text "ERROR: Invalid target: ${down_artifact}\n You must enter one of the following:"
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
readonly PHOENIX_AR_DOWN_ANDROID_ARCHIVE
readonly PHOENIX_AR_DOWN_ANDROID_JS
readonly PHOENIX_AR_DOWN_ANDROID_JS_EXTENDED
readonly PHOENIX_AR_DOWN_LINUX_ARCHIVE
readonly PHOENIX_AR_DOWN_LINUX_FLATPAK_ARCHIVE
readonly PHOENIX_AR_DOWN_OSX_ARCHIVE
readonly PHOENIX_AR_DOWN_OSX_INTEL_ARCHIVE
readonly PHOENIX_AR_DOWN_WINDOWS_ARCHIVE
readonly PHOENIX_AR_DOWN_UNIVERSAL_CFG

# Constants

# Base artifacts URL
readonly PHOENIX_CEL_ARTIFACTS_URL='https://artifacts.celenity.dev/phoenix'

# Function to download and verify the SHA512sum of an artifact
function download_artifact() {
  local readonly pipeline_id="$1"
  local readonly target="$2"
  local readonly output_dir="$3"

  if [[ "${target}" == 'windows' ]]; then
    local readonly target_archive_ext='zip'
  else
    local readonly target_archive_ext='tar.xz'
  fi

  if [[ "${target}" == 'android-js' ]]; then
    local readonly target_file="phoenix-${PHOENIX_VERSION}-android.js"
  elif [[ "${target}" == 'android-js-extended' ]]; then
    local readonly target_file="phoenix-extended-${PHOENIX_VERSION}-android.js"
  elif [[ "${target}" == 'universal-cfg' ]]; then
    local readonly target_file="phoenix-${PHOENIX_VERSION}-universal.cfg"
  else
    local readonly target_file="phoenix-${PHOENIX_VERSION}-${target}.${target_archive_ext}"
  fi

  local readonly target_expected_sha512sum="${target_file}-sha512sum.txt"
  local readonly target_expected_sha512sum_url="${PHOENIX_CEL_ARTIFACTS_URL}/${pipeline_id}/${target_expected_sha512sum}"
  local readonly target_file_url="${PHOENIX_CEL_ARTIFACTS_URL}/${pipeline_id}/${target_file}"
  local readonly output_file="${output_dir}/${target_file}"
  local readonly output_expected_sha512sum="${output_dir}/${target_expected_sha512sum}"

  # Download the artifact
  "${PHOENIX_MKDIR}" -p "${output_dir}"
  echo_red_text "Downloading ${target_file} from ${target_file_url}..."
  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --location "${target_file_url}" --output "${output_file}"
  echo_green_text "SUCCESS: Downloaded ${target_file}"

  # Check the SHA512sum
  echo_red_text "Validating SHA512sum for ${target_file}.."
  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --location "${target_expected_sha512sum_url}" --output "${output_expected_sha512sum}"
  local readonly expected_sha512sum=$("${PHOENIX_CAT}" "${output_expected_sha512sum}" | "${PHOENIX_XARGS}")
  local readonly local_sha512sum=$("${PHOENIX_SHA512SUM}" "${output_file}" | "${PHOENIX_AWK}" '{print $1}')
  if [[ "${local_sha512sum}" != "${expected_sha512sum}" ]]; then
    echo_red_text 'ERROR: Checksum validation failed.'
    echo "Expected SHA512sum: ${expected_sha512sum}"
    echo "Actual SHA512sum:   ${local_sha512sum}"

    # If checksum validation fails, also just clean-up the files
    "${PHOENIX_RM}" -f "${output_file}"
    "${PHOENIX_RM}" -f "${output_expected_sha512sum}"
    exit 1
  fi
  echo_green_text "SUCCESS: Checksum validated for ${target_file}"
  echo "SHA512sum: ${local_sha512sum}"
}

# phoenix-{PHOENIX_VERSION}-android.tar.xz
if [[ "${PHOENIX_AR_DOWN_ANDROID_ARCHIVE}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'android' "${PHOENIX_ARTIFACTS}"
fi

# phoenix-{PHOENIX_VERSION}-android.js
if [[ "${PHOENIX_AR_DOWN_ANDROID_JS}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'android-js' "${PHOENIX_ARTIFACTS}"
fi

# phoenix-extended-{PHOENIX_VERSION}-android.js
if [[ "${PHOENIX_AR_DOWN_ANDROID_JS_EXTENDED}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'android-js-extended' "${PHOENIX_ARTIFACTS}"
fi

# phoenix-{PHOENIX_VERSION}-linux.tar.xz
if [[ "${PHOENIX_AR_DOWN_LINUX_ARCHIVE}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'linux' "${PHOENIX_ARTIFACTS}"
fi

# phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
if [[ "${PHOENIX_AR_DOWN_LINUX_FLATPAK_ARCHIVE}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'linux-flatpak' "${PHOENIX_ARTIFACTS}"
fi

# phoenix-{PHOENIX_VERSION}-osx.tar.xz
if [[ "${PHOENIX_AR_DOWN_OSX_ARCHIVE}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'osx' "${PHOENIX_ARTIFACTS}"
fi

# phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
if [[ "${PHOENIX_AR_DOWN_OSX_INTEL_ARCHIVE}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'osx-intel' "${PHOENIX_ARTIFACTS}"
fi

# phoenix-{PHOENIX_VERSION}-windows.zip
if [[ "${PHOENIX_AR_DOWN_WINDOWS_ARCHIVE}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'windows' "${PHOENIX_ARTIFACTS}"
fi

# phoenix-{PHOENIX_VERSION}-universal.cfg
if [[ "${PHOENIX_AR_DOWN_UNIVERSAL_CFG}" == 1 ]]; then
  download_artifact "${PHOENIX_CI_ID}" 'universal-cfg' "${PHOENIX_ARTIFACTS}"
fi
