#!/bin/bash

set -euo pipefail

# Set verbosity
set_verbosity

# Include download utilities
verify_file_with_env "${PHOENIX_DOWNLOAD_UTILS}" 'PHOENIX_DOWNLOAD_UTILS' || return 1
source "${PHOENIX_DOWNLOAD_UTILS}" || return 1

if [[ -z "${PHOENIX_FROM_AR_DOWN+x}" ]]; then
  echo_red_text "ERROR: Do not call 'ci-download-artifacts-phoenix.sh' directly! Instead, use 'ci-download-artifacts.sh'." >&1
  return 1
fi

# Ensure we have `PHOENIX_CI`
verify_env "${PHOENIX_CI}" 'PHOENIX_CI' || return 1

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
  return 1
fi

# Ensure we have `PHOENIX_CI_ID`
verify_env "${PHOENIX_CI_ID}" 'PHOENIX_CI_ID' || return 1

# Ensure we have `PHOENIX_ARTIFACTS`
verify_env "${PHOENIX_ARTIFACTS}" 'PHOENIX_ARTIFACTS' || return 1

verify_env "${target_artifact}" 'target_artifact' || {
  echo_red_text "ERROR: Missing target artifact!"
  return 1
}

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

if [[ "${target_artifact}" == 'android-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-android.tar.xz
  PHOENIX_AR_DOWN_ANDROID_ARCHIVE=1
elif [[ "${target_artifact}" == 'android-js' ]]; then
  # phoenix-{PHOENIX_VERSION}-android.js
  PHOENIX_AR_DOWN_ANDROID_JS=1
elif [[ "${target_artifact}" == 'android-js-extended' ]]; then
  # phoenix-extended-{PHOENIX_VERSION}-android.js
  PHOENIX_AR_DOWN_ANDROID_JS_EXTENDED=1
elif [[ "${target_artifact}" == 'linux-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-linux.tar.xz
  PHOENIX_AR_DOWN_LINUX_ARCHIVE=1
elif [[ "${target_artifact}" == 'linux-flatpak-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
  PHOENIX_AR_DOWN_LINUX_FLATPAK_ARCHIVE=1
elif [[ "${target_artifact}" == 'osx-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-osx.tar.xz
  PHOENIX_AR_DOWN_OSX_ARCHIVE=1
elif [[ "${target_artifact}" == 'osx-intel-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
  PHOENIX_AR_DOWN_OSX_INTEL_ARCHIVE=1
elif [[ "${target_artifact}" == 'windows-archive' ]]; then
  # phoenix-{PHOENIX_VERSION}-windows.zip
  PHOENIX_AR_DOWN_WINDOWS_ARCHIVE=1
elif [[ "${target_artifact}" == 'universal-cfg' ]]; then
  # phoenix-{PHOENIX_VERSION}-universal.cfg
  PHOENIX_AR_DOWN_UNIVERSAL_CFG=1
elif [[ "${target_artifact}" == 'all' ]]; then
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
  echo_red_text "ERROR: Invalid target: '${target_artifact}'\n You must enter one of the following:"
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
  return 1
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

# Download and verify the SHA512sum of an artifact
function download_artifact() {
  function print_usage() {
    echo "Usage: download_artifact 'pipeline_id' 'artifact_name' 'path/to/download/artifact/to'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please provide the pipeline ID to download the artifact from!'
    print_usage
    return 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please provide the name of the artifact to download!'
    print_usage
    return 1
  fi

  if [[ -z "${3+x}" ]]; then
    echo_red_text 'ERROR: Please provide the path to download the artifact to!'
    print_usage
    return 1
  fi

  # Ensure we have cat
  verify_exec "${PHOENIX_CAT}" 'PHOENIX_CAT' || return 1

  # Ensure we have GNU awk
  verify_exec "${PHOENIX_AWK}" 'PHOENIX_AWK' || return 1

  # Ensure we have rm
  verify_exec "${PHOENIX_RM}" 'PHOENIX_RM' || return 1

  # Ensure we have shasum
  verify_exec "${PHOENIX_SHASUM}" 'PHOENIX_SHASUM' || return 1

  # Ensure we have xargs
  verify_exec "${PHOENIX_XARGS}" 'PHOENIX_XARGS' || return 1

  # Ensure we have `PHOENIX_VERSION`
  verify_env "${PHOENIX_VERSION}" 'PHOENIX_VERSION' || return 1

  # Ensure we have `PHOENIX_CEL_ARTIFACTS_URL`
  verify_env "${PHOENIX_CEL_ARTIFACTS_URL}" 'PHOENIX_CEL_ARTIFACTS_URL' || return 1

  local -r pipeline_id="$1"
  local -r target="$2"
  local -r output_dir="$3"

  if [[ "${target}" == 'windows' ]]; then
    local -r target_archive_ext='zip'
  else
    local -r target_archive_ext='tar.xz'
  fi

  if [[ "${target}" == 'android-js' ]]; then
    local -r target_file="phoenix-${PHOENIX_VERSION}-android.js"
  elif [[ "${target}" == 'android-js-extended' ]]; then
    local -r target_file="phoenix-extended-${PHOENIX_VERSION}-android.js"
  elif [[ "${target}" == 'universal-cfg' ]]; then
    local -r target_file="phoenix-${PHOENIX_VERSION}-universal.cfg"
  else
    local -r target_file="phoenix-${PHOENIX_VERSION}-${target}.${target_archive_ext}"
  fi

  local -r target_expected_sha512sum="${target_file}-sha512sum.txt"
  local -r target_expected_sha512sum_url="${PHOENIX_CEL_ARTIFACTS_URL}/${pipeline_id}/${target_expected_sha512sum}"
  local -r target_file_url="${PHOENIX_CEL_ARTIFACTS_URL}/${pipeline_id}/${target_file}"
  local -r output_file="${output_dir}/${target_file}"
  local -r output_expected_sha512sum="${output_dir}/${target_expected_sha512sum}"

  # Download the artifact
  download "${target_file_url}" "${output_file}"

  # Check the SHA512sum
  echo_red_text "Validating SHA512sum for file: '${target_file}'..."
  download "${target_expected_sha512sum_url}" "${output_expected_sha512sum}"
  local -r expected_sha512sum=$("${PHOENIX_CAT}" "${output_expected_sha512sum}" | "${PHOENIX_XARGS}")
  local -r local_sha512sum=$("${PHOENIX_SHASUM}" -a 512 "${output_file}" | "${PHOENIX_AWK}" '{print $1}')
  if [[ "${local_sha512sum}" != "${expected_sha512sum}" ]]; then
    echo_red_text "ERROR: Checksum validation for file failed: '${target_file}'!"
    echo "Expected SHA512sum: '${expected_sha512sum}'"
    echo "Actual SHA512sum:   '${local_sha512sum}'"

    # If checksum validation fails, also just clean-up the files
    "${PHOENIX_RM}" -f "${output_file}"
    "${PHOENIX_RM}" -f "${output_expected_sha512sum}"
    return 1
  fi
  echo_green_text "SUCCESS: Validated checksum for file: '${target_file}'!"
  echo "SHA512sum: '${local_sha512sum}'"
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
