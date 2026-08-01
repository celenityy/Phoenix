#!/bin/bash

set -euo pipefail

# Ensure this is never ran with xtrace...
set +x

# Set-up our environment
if [[ -z "${PHOENIX_CI+x}" ]]; then
  export PHOENIX_CI=1
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

if [[ -z "${PHOENIX_FROM_PUSH+x}" ]]; then
  echo_red_text 'ERROR: Do not call ci-push-phoenix.sh directly. Instead, use ci-push.sh.' >&1
  exit 1
fi

# Verify secrets
verify_file_with_env "${PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE}" 'PHOENIX_CEL_RELEASES_S3_ACCESS_KEY_FILE' || exit 1
verify_file_with_env "${PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE}" 'PHOENIX_CEL_RELEASES_S3_BUCKET_NAME_FILE' || exit 1
verify_file_with_env "${PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE}" 'PHOENIX_CEL_RELEASES_S3_ENDPOINT_FILE' || exit 1
verify_file_with_env "${PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE}" 'PHOENIX_CEL_RELEASES_S3_SECRET_KEY_FILE' || exit 1

# Include version info
source "${PHOENIX_VERSIONS}"

# Constants

# Base releases URL
readonly PHOENIX_CEL_RELEASES_URL='https://releases.celenity.dev'
readonly PHOENIX_RELEASES_BASE_URL="${PHOENIX_CEL_RELEASES_URL}/phoenix/releases/${PHOENIX_VERSION}"

# Forgejo (Codeberg)
readonly PHOENIX_FORGEJO_API_URL='https://codeberg.org/api'
readonly PHOENIX_FORGEJO_BRANCH='pages'
readonly PHOENIX_FORGEJO_GENERIC_PACKAGES_URL="${PHOENIX_FORGEJO_API_URL}/packages/celenity/generic"
readonly PHOENIX_FORGEJO_PACKAGE_NAME='phoenix'
readonly PHOENIX_FORGEJO_REPO='celenity/Phoenix'
readonly PHOENIX_FORGEJO_USER='darthvader'

# GitHub
readonly PHOENIX_GITHUB_API_URL='https://api.github.com'
readonly PHOENIX_GITHUB_BRANCH='pages'
readonly PHOENIX_GITHUB_REPO='celenityy/Phoenix'

# GitLab
readonly PHOENIX_GITLAB_API_URL='https://gitlab.com/api/v4'
readonly PHOENIX_GITLAB_BRANCH='pages'
readonly PHOENIX_GITLAB_PACKAGE_NAME='phoenix'
readonly PHOENIX_GITLAB_PROJECT_ID='65954487'
readonly PHOENIX_GITLAB_GENERIC_PACKAGES_URL="${PHOENIX_GITLAB_API_URL}/projects/${PHOENIX_GITLAB_PROJECT_ID}/packages/generic"

# Create release notes
function create_release_notes() {
  # Ensure our changelog (for release-specific changes) exists
  local readonly PHOENIX_CHANGELOG_FILE="${PHOENIX_ROOT}/CHANGELOG.md"
  verify_file "${PHOENIX_CHANGELOG_FILE}" || exit 1

  # Ensure our release template exists
  local readonly PHOENIX_RELEASE_TEMPLATE="${PHOENIX_TEMPLATES}/release-notes.md"
  verify_file "${PHOENIX_RELEASE_TEMPLATE}" || exit 1

  local readonly PHOENIX_RELEASE_NOTES="${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-release-notes.md"
  local readonly PHOENIX_RELEASE_NOTES_TEMP="${PHOENIX_TEMP}/phoenix-${PHOENIX_VERSION}-release-notes-temp.md"
  "${PHOENIX_RM}" -f "${PHOENIX_RELEASE_NOTES}" "${PHOENIX_RELEASE_NOTES_TEMP}"

  "${PHOENIX_MKDIR}" -p "${PHOENIX_ARTIFACTS}" "${PHOENIX_TEMP}"
  "${PHOENIX_CP}" -f "${PHOENIX_RELEASE_TEMPLATE}" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # Set our version
  "${PHOENIX_SED}" -i "s|{PHOENIX_VERSION}|${PHOENIX_VERSION}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # Set the previous (current) version
  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --location "${PHOENIX_CEL_RELEASES_URL}/phoenix/releases/latest_release.txt" --output "${PHOENIX_TEMP}/previous_release.txt"
  local readonly PHOENIX_PREVIOUS_VERSION=$("${PHOENIX_CAT}" "${PHOENIX_TEMP}/previous_release.txt" | "${PHOENIX_XARGS}")
  "${PHOENIX_SED}" -i "s|{PHOENIX_PREVIOUS_VERSION}|${PHOENIX_PREVIOUS_VERSION}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # Set our SHA512sums

  # phoenix-{PHOENIX_VERSION}-android.tar.xz
  local readonly PHOENIX_ANDROID_ARCHIVE_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-android.tar.xz" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_ANDROID_ARCHIVE_SHA512SUM}|${PHOENIX_ANDROID_ARCHIVE_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # phoenix-{PHOENIX_VERSION}-android.js
  local readonly PHOENIX_ANDROID_JS_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-android.js" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_ANDROID_JS_SHA512SUM}|${PHOENIX_ANDROID_JS_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # phoenix-extended-{PHOENIX_VERSION}-android.js
  local readonly PHOENIX_EXTENDED_ANDROID_JS_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-extended-${PHOENIX_VERSION}-android.js" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_EXTENDED_ANDROID_JS_SHA512SUM}|${PHOENIX_EXTENDED_ANDROID_JS_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # phoenix-{PHOENIX_VERSION}-linux.tar.xz
  local readonly PHOENIX_LINUX_ARCHIVE_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-linux.tar.xz" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_LINUX_ARCHIVE_SHA512SUM}|${PHOENIX_LINUX_ARCHIVE_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
  local readonly PHOENIX_LINUX_FLATPAK_ARCHIVE_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-linux-flatpak.tar.xz" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_LINUX_FLATPAK_ARCHIVE_SHA512SUM}|${PHOENIX_LINUX_FLATPAK_ARCHIVE_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # phoenix-{PHOENIX_VERSION}-osx.tar.xz
  local readonly PHOENIX_OSX_ARCHIVE_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-osx.tar.xz" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_OSX_ARCHIVE_SHA512SUM}|${PHOENIX_OSX_ARCHIVE_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
  local readonly PHOENIX_OSX_INTEL_ARCHIVE_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-osx-intel.tar.xz" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_OSX_INTEL_ARCHIVE_SHA512SUM}|${PHOENIX_OSX_INTEL_ARCHIVE_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # phoenix-{PHOENIX_VERSION}-windows.zip
  local readonly PHOENIX_WINDOWS_ARCHIVE_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-windows.zip" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_WINDOWS_ARCHIVE_SHA512SUM}|${PHOENIX_WINDOWS_ARCHIVE_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # phoenix-{PHOENIX_VERSION}-universal.cfg
  local readonly PHOENIX_UNIVERSAL_CFG_SHA512SUM=$("${PHOENIX_SHA512SUM}" "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-universal.cfg" | "${PHOENIX_AWK}" '{print $1}')
  "${PHOENIX_SED}" -i "s|{PHOENIX_UNIVERSAL_CFG_SHA512SUM}|${PHOENIX_UNIVERSAL_CFG_SHA512SUM}|g" "${PHOENIX_RELEASE_NOTES_TEMP}"

  # Add release-specific changes
  local readonly PHOENIX_CHANGELOG=$("${PHOENIX_CAT}" "${PHOENIX_CHANGELOG_FILE}")
  {
    echo "# Phoenix ${PHOENIX_VERSION}"
    echo '____'
    echo ''
    echo '## Changes'
    echo ''
    "${PHOENIX_CAT}" "${PHOENIX_ROOT}/CHANGELOG.md"
    echo ''
    "${PHOENIX_CAT}" "${PHOENIX_RELEASE_NOTES_TEMP}"
  } >> "${PHOENIX_RELEASE_NOTES}"

  "${PHOENIX_RM}" -f "${PHOENIX_RELEASE_NOTES_TEMP}"

  echo_green_text "SUCCESS: Created release notes for Phoenix: ${PHOENIX_VERSION}"
}

# Upload a release to Forgejo (Codeberg)'s package registry
function upload_to_forgejo_package_registry() {
  function print_usage() {
    echo "Usage: upload_to_forgejo_package_registry '/path/to/release'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to the Forgejo package registry'
    print_usage
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${PHOENIX_FORGEJO_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing Forgejo CI API Token! Please set PHOENIX_FORGEJO_CI_API_TOKEN.'
    exit 1
  fi

  local readonly upload_file="$1"
  local readonly upload_file_name="$("${PHOENIX_BASENAME}" "${upload_file}")"

  # Ensure our file to upload is valid
  verify_file "${upload_file}" || exit 1

  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --no-verbose --user "${PHOENIX_FORGEJO_USER}:${PHOENIX_FORGEJO_CI_API_TOKEN}" \
    --upload-file "${upload_file}" \
    "${PHOENIX_FORGEJO_GENERIC_PACKAGES_URL}/${PHOENIX_FORGEJO_PACKAGE_NAME}/${PHOENIX_VERSION}/${upload_file_name}"
}

# Upload a release to GitLab's package registry
function upload_to_gitlab_package_registry() {
  function print_usage() {
    echo "Usage: upload_to_gitlab_package_registry '/path/to/release'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the path to a file that should be uploaded to the GitLab package registry'
    print_usage
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${PHOENIX_GITLAB_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing GitLab CI API Token! Please set PHOENIX_GITLAB_CI_API_TOKEN.'
    exit 1
  fi

  local readonly upload_file="$1"
  local readonly upload_file_name="$("${PHOENIX_BASENAME}" "${upload_file}")"

  # Ensure our file to upload is valid
  verify_file "${upload_file}" || exit 1

  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --no-verbose --header "PRIVATE-TOKEN: ${PHOENIX_GITLAB_CI_API_TOKEN}" \
    --upload-file "${upload_file}" \
    "${PHOENIX_GITLAB_GENERIC_PACKAGES_URL}/${PHOENIX_GITLAB_PACKAGE_NAME}/${PHOENIX_VERSION}/${upload_file_name}"
}

# Add an asset to a Forgejo (Codeberg) release
function add_asset_to_forgejo_release() {
  function print_usage() {
    echo "Usage: add_asset_to_forgejo_release 'release_id' 'https://totally.real.url/asset'"
  }

  if [[ -z "${1+x}" ]]; then
    echo_red_text 'ERROR: Please specify the ID of the release we should attach the asset to!'
    print_usage
    exit 1
  fi

  if [[ -z "${2+x}" ]]; then
    echo_red_text 'ERROR: Please specify the external URL of an asset to attach!'
    print_usage
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${PHOENIX_FORGEJO_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing Forgejo CI API Token! Please set PHOENIX_FORGEJO_CI_API_TOKEN.'
    exit 1
  fi

  local readonly release_id="$1"
  local readonly asset_url="$2"
  local readonly asset=$("${PHOENIX_BASENAME}" "${asset_url}")

  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --no-verbose --header 'accept: application/json' \
    --header "Authorization: token ${PHOENIX_FORGEJO_CI_API_TOKEN}" \
    -F "external_url=${asset_url}" \
    --request POST \
    "${PHOENIX_FORGEJO_API_URL}/v1/repos/${PHOENIX_FORGEJO_REPO}/releases/${release_id}/assets?name=$(printf '%s' "${asset}" | "${PHOENIX_JQ}" -sRr @uri)"

  echo_green_text "SUCCESS: Added ${asset} to release: ${PHOENIX_VERSION}"
}

# Publish a release to Forgejo (Codeberg)
function publish_to_forgejo() {
  local readonly PHOENIX_RELEASE_NOTES="${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-release-notes.md"

  if [[ ! -f "${PHOENIX_RELEASE_NOTES}" ]]; then
    echo_red_text "ERROR: Missing release notes! (${PHOENIX_RELEASE_NOTES})"
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${PHOENIX_FORGEJO_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing Forgejo CI API Token! Please set PHOENIX_FORGEJO_CI_API_TOKEN.'
    exit 1
  fi

  local readonly phoenix_release_desc=$("${PHOENIX_CAT}" "${PHOENIX_RELEASE_NOTES}")

  local readonly phoenix_codeberg_release_data="$(
    "${PHOENIX_JQ}" -Rs --arg name "${PHOENIX_VERSION}" --arg ref "${PHOENIX_FORGEJO_BRANCH}" --arg tag "${PHOENIX_VERSION}" '{
      name: $name,
      tag_name: $tag,
      target_commitish: $ref,
      draft: false,
      prerelease: false,
      body: .
      }' <<< "${phoenix_release_desc}"
  )"

  local readonly phoenix_codeberg_release=$("${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --no-verbose --header 'Content-Type: application/json' \
    --header 'accept: application/json' \
    --header "Authorization: token ${PHOENIX_FORGEJO_CI_API_TOKEN}" \
    --data "${phoenix_codeberg_release_data}" \
    --request POST \
    "${PHOENIX_FORGEJO_API_URL}/v1/repos/${PHOENIX_FORGEJO_REPO}/releases")

  # Get our release ID
  local readonly phoenix_codeberg_release_id=$(echo "${phoenix_codeberg_release}" | "${PHOENIX_JQ}" -r '.id')

  # Attach our assets

  # phoenix-{PHOENIX_VERSION}-android.tar.xz
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/android/phoenix-${PHOENIX_VERSION}-android.tar.xz"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/android/phoenix-${PHOENIX_VERSION}-android.tar.xz-sha512sum.txt"

  # phoenix-{PHOENIX_VERSION}-android.js
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/android/phoenix-${PHOENIX_VERSION}-android.js"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/android/phoenix-${PHOENIX_VERSION}-android.js-sha512sum.txt"

  # phoenix-extended-{PHOENIX_VERSION}-android.js
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/android/phoenix-extended-${PHOENIX_VERSION}-android.js"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/android/phoenix-extended-${PHOENIX_VERSION}-android.js-sha512sum.txt"

  # phoenix-{PHOENIX_VERSION}-linux.tar.xz
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/linux/phoenix-${PHOENIX_VERSION}-linux.tar.xz"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/linux/phoenix-${PHOENIX_VERSION}-linux.tar.xz-sha512sum.txt"

  # phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/linux-flatpak/phoenix-${PHOENIX_VERSION}-linux-flatpak.tar.xz"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/linux-flatpak/phoenix-${PHOENIX_VERSION}-linux-flatpak.tar.xz-sha512sum.txt"

  # phoenix-{PHOENIX_VERSION}-osx.tar.xz
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/osx/phoenix-${PHOENIX_VERSION}-osx.tar.xz"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/osx/phoenix-${PHOENIX_VERSION}-osx.tar.xz-sha512sum.txt"

  # phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/osx-intel/phoenix-${PHOENIX_VERSION}-osx-intel.tar.xz"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/osx-intel/phoenix-${PHOENIX_VERSION}-osx-intel.tar.xz-sha512sum.txt"

  # phoenix-{PHOENIX_VERSION}-windows.zip
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/windows/phoenix-${PHOENIX_VERSION}-windows.zip"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/windows/phoenix-${PHOENIX_VERSION}-windows.zip-sha512sum.txt"

  # phoenix-{PHOENIX_VERSION}-universal.cfg
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/universal/phoenix-${PHOENIX_VERSION}-universal.cfg"
  add_asset_to_forgejo_release "${phoenix_codeberg_release_id}" "${PHOENIX_RELEASES_BASE_URL}/universal/phoenix-${PHOENIX_VERSION}-universal.cfg-sha512sum.txt"

  # We're done! :)
  echo_green_text "SUCCESS: Published Phoenix: ${PHOENIX_VERSION} to Forgejo"
}

# Publish a release to GitHub
function publish_to_github() {
  local readonly PHOENIX_RELEASE_NOTES="${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-release-notes.md"

  if [[ ! -f "${PHOENIX_RELEASE_NOTES}" ]]; then
    echo_red_text "ERROR: Missing release notes! (${PHOENIX_RELEASE_NOTES})"
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${PHOENIX_GITHUB_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing GitHub CI API Token! Please set PHOENIX_GITHUB_CI_API_TOKEN.'
    exit 1
  fi

  local readonly phoenix_release_desc=$("${PHOENIX_CAT}" "${PHOENIX_RELEASE_NOTES}")

  local readonly phoenix_github_release_data="$(
    "${PHOENIX_JQ}" -Rs --arg name "${PHOENIX_VERSION}" --arg ref "${PHOENIX_GITHUB_BRANCH}" --arg tag "${PHOENIX_VERSION}" '{
      name: $name,
      tag_name: $tag,
      target_commitish: $ref,
      draft: false,
      prerelease: false,
      body: .
      }' <<< "${phoenix_release_desc}"
  )"

  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --no-verbose --header 'Content-Type: application/json' \
    --header 'Accept: application/vnd.github+json' \
    --header "Authorization: Bearer ${PHOENIX_GITHUB_CI_API_TOKEN}" \
    --header "X-GitHub-Api-Version: 2026-03-10" \
    --data "${phoenix_github_release_data}" \
    --request POST \
    "${PHOENIX_GITHUB_API_URL}/repos/${PHOENIX_GITHUB_REPO}/releases"

  # We're done! :)
  echo_green_text "SUCCESS: Published Phoenix: ${PHOENIX_VERSION} to GitHub"
}

# Publish a release to GitLab
function publish_to_gitlab() {
  local readonly PHOENIX_RELEASE_NOTES="${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-release-notes.md"

  if [[ ! -f "${PHOENIX_RELEASE_NOTES}" ]]; then
    echo_red_text "ERROR: Missing release notes! (${PHOENIX_RELEASE_NOTES})"
    exit 1
  fi

  # Ensure we have an API token...
  if [[ -z "${PHOENIX_GITLAB_CI_API_TOKEN+x}" ]]; then
    echo_red_text 'ERROR: Missing GitLab CI API Token! Please set PHOENIX_GITLAB_CI_API_TOKEN.'
    exit 1
  fi

  local readonly phoenix_release_desc=$("${PHOENIX_CAT}" "${PHOENIX_RELEASE_NOTES}")

  # Attach our assets

  # phoenix-{PHOENIX_VERSION}-android.tar.xz
  local readonly PHOENIX_ANDROID_ARCHIVE_NAME="phoenix-${PHOENIX_VERSION}-android.tar.xz"
  local readonly PHOENIX_ANDROID_ARCHIVE_URL="${PHOENIX_RELEASES_BASE_URL}/android/${PHOENIX_ANDROID_ARCHIVE_NAME}"
  local readonly PHOENIX_ANDROID_ARCHIVE_SHA512SUM_NAME="${PHOENIX_ANDROID_ARCHIVE_NAME}-sha512sum.txt"
  local readonly PHOENIX_ANDROID_ARCHIVE_SHA512SUM_URL="${PHOENIX_ANDROID_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_ANDROID_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_ANDROID_ARCHIVE_SHA512SUM_NAME}"

  # phoenix-{PHOENIX_VERSION}-android.js
  local readonly PHOENIX_ANDROID_JS_NAME="phoenix-${PHOENIX_VERSION}-android.js"
  local readonly PHOENIX_ANDROID_JS_URL="${PHOENIX_RELEASES_BASE_URL}/android/${PHOENIX_ANDROID_JS_NAME}"
  local readonly PHOENIX_ANDROID_JS_SHA512SUM_NAME="${PHOENIX_ANDROID_JS_NAME}-sha512sum.txt"
  local readonly PHOENIX_ANDROID_JS_SHA512SUM_URL="${PHOENIX_ANDROID_JS_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_ANDROID_JS_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_ANDROID_JS_SHA512SUM_NAME}"

  # phoenix-extended-{PHOENIX_VERSION}-android.js
  local readonly PHOENIX_EXTENDED_ANDROID_JS_NAME="phoenix-extended-${PHOENIX_VERSION}-android.js"
  local readonly PHOENIX_EXTENDED_ANDROID_JS_URL="${PHOENIX_RELEASES_BASE_URL}/android/${PHOENIX_EXTENDED_ANDROID_JS_NAME}"
  local readonly PHOENIX_EXTENDED_ANDROID_JS_SHA512SUM_NAME="${PHOENIX_EXTENDED_ANDROID_JS_NAME}-sha512sum.txt"
  local readonly PHOENIX_EXTENDED_ANDROID_JS_SHA512SUM_URL="${PHOENIX_EXTENDED_ANDROID_JS_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_EXTENDED_ANDROID_JS_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_EXTENDED_ANDROID_JS_SHA512SUM_NAME}"

  # phoenix-{PHOENIX_VERSION}-linux.tar.xz
  local readonly PHOENIX_LINUX_ARCHIVE_NAME="phoenix-${PHOENIX_VERSION}-linux.tar.xz"
  local readonly PHOENIX_LINUX_ARCHIVE_URL="${PHOENIX_RELEASES_BASE_URL}/linux/${PHOENIX_LINUX_ARCHIVE_NAME}"
  local readonly PHOENIX_LINUX_ARCHIVE_SHA512SUM_NAME="${PHOENIX_LINUX_ARCHIVE_NAME}-sha512sum.txt"
  local readonly PHOENIX_LINUX_ARCHIVE_SHA512SUM_URL="${PHOENIX_LINUX_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_LINUX_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_LINUX_ARCHIVE_SHA512SUM_NAME}"

  # phoenix-{PHOENIX_VERSION}-linux-flatpak.tar.xz
  local readonly PHOENIX_LINUX_FLATPAK_ARCHIVE_NAME="phoenix-${PHOENIX_VERSION}-linux-flatpak.tar.xz"
  local readonly PHOENIX_LINUX_FLATPAK_ARCHIVE_URL="${PHOENIX_RELEASES_BASE_URL}/linux-flatpak/${PHOENIX_LINUX_FLATPAK_ARCHIVE_NAME}"
  local readonly PHOENIX_LINUX_FLATPAK_ARCHIVE_SHA512SUM_NAME="${PHOENIX_LINUX_FLATPAK_ARCHIVE_NAME}-sha512sum.txt"
  local readonly PHOENIX_LINUX_FLATPAK_ARCHIVE_SHA512SUM_URL="${PHOENIX_LINUX_FLATPAK_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_LINUX_FLATPAK_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_LINUX_FLATPAK_ARCHIVE_SHA512SUM_NAME}"

  # phoenix-{PHOENIX_VERSION}-osx.tar.xz
  local readonly PHOENIX_OSX_ARCHIVE_NAME="phoenix-${PHOENIX_VERSION}-osx.tar.xz"
  local readonly PHOENIX_OSX_ARCHIVE_URL="${PHOENIX_RELEASES_BASE_URL}/osx/${PHOENIX_OSX_ARCHIVE_NAME}"
  local readonly PHOENIX_OSX_ARCHIVE_SHA512SUM_NAME="${PHOENIX_OSX_ARCHIVE_NAME}-sha512sum.txt"
  local readonly PHOENIX_OSX_ARCHIVE_SHA512SUM_URL="${PHOENIX_OSX_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_OSX_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_OSX_ARCHIVE_SHA512SUM_NAME}"

  # phoenix-{PHOENIX_VERSION}-osx-intel.tar.xz
  local readonly PHOENIX_OSX_INTEL_ARCHIVE_NAME="phoenix-${PHOENIX_VERSION}-osx-intel.tar.xz"
  local readonly PHOENIX_OSX_INTEL_ARCHIVE_URL="${PHOENIX_RELEASES_BASE_URL}/osx-intel/${PHOENIX_OSX_INTEL_ARCHIVE_NAME}"
  local readonly PHOENIX_OSX_INTEL_ARCHIVE_SHA512SUM_NAME="${PHOENIX_OSX_INTEL_ARCHIVE_NAME}-sha512sum.txt"
  local readonly PHOENIX_OSX_INTEL_ARCHIVE_SHA512SUM_URL="${PHOENIX_OSX_INTEL_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_OSX_INTEL_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_OSX_INTEL_ARCHIVE_SHA512SUM_NAME}"

  # phoenix-{PHOENIX_VERSION}-windows.zip
  local readonly PHOENIX_WINDOWS_ARCHIVE_NAME="phoenix-${PHOENIX_VERSION}-windows.zip"
  local readonly PHOENIX_WINDOWS_ARCHIVE_URL="${PHOENIX_RELEASES_BASE_URL}/windows/${PHOENIX_WINDOWS_ARCHIVE_NAME}"
  local readonly PHOENIX_WINDOWS_ARCHIVE_SHA512SUM_NAME="${PHOENIX_WINDOWS_ARCHIVE_NAME}-sha512sum.txt"
  local readonly PHOENIX_WINDOWS_ARCHIVE_SHA512SUM_URL="${PHOENIX_WINDOWS_ARCHIVE_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_WINDOWS_ARCHIVE_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_WINDOWS_ARCHIVE_SHA512SUM_NAME}"

  # phoenix-{PHOENIX_VERSION}-universal.cfg
  local readonly PHOENIX_UNIVERSAL_CFG_NAME="phoenix-${PHOENIX_VERSION}-universal.cfg"
  local readonly PHOENIX_UNIVERSAL_CFG_URL="${PHOENIX_RELEASES_BASE_URL}/universal/${PHOENIX_UNIVERSAL_CFG_NAME}"
  local readonly PHOENIX_UNIVERSAL_CFG_SHA512SUM_NAME="${PHOENIX_UNIVERSAL_CFG_NAME}-sha512sum.txt"
  local readonly PHOENIX_UNIVERSAL_CFG_SHA512SUM_URL="${PHOENIX_UNIVERSAL_CFG_URL}-sha512sum.txt"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_UNIVERSAL_CFG_NAME}"
  upload_to_gitlab_package_registry "${PHOENIX_ARTIFACTS}/${PHOENIX_UNIVERSAL_CFG_SHA512SUM_NAME}"

  local readonly phoenix_gitlab_release_data="$(
    "${PHOENIX_JQ}" -Rs --arg name "${PHOENIX_VERSION}" --arg ref "${PHOENIX_GITLAB_BRANCH}" --arg tag "${PHOENIX_VERSION}" --arg version "${PHOENIX_VERSION}" \
    --arg android_archive_name "${PHOENIX_ANDROID_ARCHIVE_NAME}" \
    --arg android_archive_url "${PHOENIX_ANDROID_ARCHIVE_URL}" \
    --arg android_archive_sha512sum_name "${PHOENIX_ANDROID_ARCHIVE_SHA512SUM_NAME}" \
    --arg android_archive_sha512sum_url "${PHOENIX_ANDROID_ARCHIVE_SHA512SUM_URL}" \
    --arg android_js_name "${PHOENIX_ANDROID_JS_NAME}" \
    --arg android_js_url "${PHOENIX_ANDROID_JS_URL}" \
    --arg android_js_sha512sum_name "${PHOENIX_ANDROID_JS_SHA512SUM_NAME}" \
    --arg android_js_sha512sum_url "${PHOENIX_ANDROID_JS_SHA512SUM_URL}" \
    --arg extended_android_js_name "${PHOENIX_EXTENDED_ANDROID_JS_NAME}" \
    --arg extended_android_js_url "${PHOENIX_EXTENDED_ANDROID_JS_URL}" \
    --arg extended_android_js_sha512sum_name "${PHOENIX_EXTENDED_ANDROID_JS_SHA512SUM_NAME}" \
    --arg extended_android_js_sha512sum_url "${PHOENIX_EXTENDED_ANDROID_JS_SHA512SUM_URL}" \
    --arg linux_archive_name "${PHOENIX_LINUX_ARCHIVE_NAME}" \
    --arg linux_archive_url "${PHOENIX_LINUX_ARCHIVE_URL}" \
    --arg linux_archive_sha512sum_name "${PHOENIX_LINUX_ARCHIVE_SHA512SUM_NAME}" \
    --arg linux_archive_sha512sum_url "${PHOENIX_LINUX_ARCHIVE_SHA512SUM_URL}" \
    --arg linux_flatpak_archive_name "${PHOENIX_LINUX_FLATPAK_ARCHIVE_NAME}" \
    --arg linux_flatpak_archive_url "${PHOENIX_LINUX_FLATPAK_ARCHIVE_URL}" \
    --arg linux_flatpak_archive_sha512sum_name "${PHOENIX_LINUX_FLATPAK_ARCHIVE_SHA512SUM_NAME}" \
    --arg linux_flatpak_archive_sha512sum_url "${PHOENIX_LINUX_FLATPAK_ARCHIVE_SHA512SUM_URL}" \
    --arg osx_archive_name "${PHOENIX_OSX_ARCHIVE_NAME}" \
    --arg osx_archive_url "${PHOENIX_OSX_ARCHIVE_URL}" \
    --arg osx_archive_sha512sum_name "${PHOENIX_OSX_ARCHIVE_SHA512SUM_NAME}" \
    --arg osx_archive_sha512sum_url "${PHOENIX_OSX_ARCHIVE_SHA512SUM_URL}" \
    --arg osx_intel_archive_name "${PHOENIX_OSX_INTEL_ARCHIVE_NAME}" \
    --arg osx_intel_archive_url "${PHOENIX_OSX_INTEL_ARCHIVE_URL}" \
    --arg osx_intel_archive_sha512sum_name "${PHOENIX_OSX_INTEL_ARCHIVE_SHA512SUM_NAME}" \
    --arg osx_intel_archive_sha512sum_url "${PHOENIX_OSX_INTEL_ARCHIVE_SHA512SUM_URL}" \
    --arg windows_archive_name "${PHOENIX_WINDOWS_ARCHIVE_NAME}" \
    --arg windows_archive_url "${PHOENIX_WINDOWS_ARCHIVE_URL}" \
    --arg windows_archive_sha512sum_name "${PHOENIX_WINDOWS_ARCHIVE_SHA512SUM_NAME}" \
    --arg windows_archive_sha512sum_url "${PHOENIX_WINDOWS_ARCHIVE_SHA512SUM_URL}" \
    --arg universal_cfg_name "${PHOENIX_UNIVERSAL_CFG_NAME}" \
    --arg universal_cfg_url "${PHOENIX_UNIVERSAL_CFG_URL}" \
    --arg universal_cfg_sha512sum_name "${PHOENIX_UNIVERSAL_CFG_SHA512SUM_NAME}" \
    --arg universal_cfg_sha512sum_url "${PHOENIX_UNIVERSAL_CFG_SHA512SUM_URL}" \
    '{
      name: $name,
      ref: $ref,
      tag_name: $tag,
      assets: {
        links: [
          {
            name: $android_archive_name,
            url: $android_archive_url,
            link_type: "package"
          },
          {
            name: $android_archive_sha512sum_name,
            url: $android_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $android_js_name,
            url: $android_js_url,
            link_type: "package"
          },
          {
            name: $android_js_sha512sum_name,
            url: $android_js_sha512sum_url,
            link_type: "package"
          },
          {
            name: $extended_android_js_name,
            url: $extended_android_js_url,
            link_type: "package"
          },
          {
            name: $extended_android_js_sha512sum_name,
            url: $extended_android_js_sha512sum_url,
            link_type: "package"
          },
          {
            name: $linux_archive_name,
            url: $linux_archive_url,
            link_type: "package"
          },
          {
            name: $linux_archive_sha512sum_name,
            url: $linux_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $linux_flatpak_archive_name,
            url: $linux_flatpak_archive_url,
            link_type: "package"
          },
          {
            name: $linux_flatpak_archive_sha512sum_name,
            url: $linux_flatpak_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $osx_archive_name,
            url: $osx_archive_url,
            link_type: "package"
          },
          {
            name: $osx_archive_sha512sum_name,
            url: $osx_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $osx_intel_archive_name,
            url: $osx_intel_archive_url,
            link_type: "package"
          },
          {
            name: $osx_intel_archive_sha512sum_name,
            url: $osx_intel_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $windows_archive_name,
            url: $windows_archive_url,
            link_type: "package"
          },
          {
            name: $windows_archive_sha512sum_name,
            url: $windows_archive_sha512sum_url,
            link_type: "package"
          },
          {
            name: $universal_cfg_name,
            url: $universal_cfg_url,
            link_type: "package"
          },
          {
            name: $universal_cfg_sha512sum_name,
            url: $universal_cfg_sha512sum_url,
            link_type: "package"
          }
        ]
      },
      description: .
      }' <<< "${phoenix_release_desc}"
  )"

  "${PHOENIX_CURL}" ${PHOENIX_CURL_FLAGS} --no-verbose --header 'Content-Type: application/json' \
    --header "PRIVATE-TOKEN: ${PHOENIX_GITLAB_CI_API_TOKEN}" \
    --data "${phoenix_gitlab_release_data}" \
    --request POST \
    "${PHOENIX_GITLAB_API_URL}/projects/${PHOENIX_GITLAB_PROJECT_ID}/releases"

  # We're done! :)
  echo_green_text "SUCCESS: Published Phoenix: ${PHOENIX_VERSION} to GitLab"
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
  verify_file "${push_file}" || exit 1

  # Set our MIME type
  case "${push_file}" in
    *.cfg)
      local readonly mime_type='text/javascript'
      ;;
    *.js)
      local readonly mime_type='text/javascript'
      ;;
    *.md)
      local readonly mime_type='text/markdown'
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
  verify_file "${sha512sum_file_in}" || exit 1

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
  verify_file "${file_in}" || exit 1

  # Push our file to S3
  push_file "${file_in}" "${s3_path_out}"

  # Create and push a SHA512sum for our file to S3
  add_sha512sum "${file_in}" "${s3_path_out}"
}

# Push a universal Phoenix configuration file
function push_phoenix_universal() {
  push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-universal.cfg" "phoenix/releases/${PHOENIX_VERSION}/universal"

  # Ensure the latest version can always be downloaded from https://releases.celenity.dev/phoenix/releases/latest/{phoenix_platform}/phoenix-latest-{phoenix_platform}.cfg
  ## (Ex. for convenience/packaging)
  "${PHOENIX_CP}" -f "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-universal.cfg" "${PHOENIX_ARTIFACTS}/phoenix-latest-universal.cfg"
  push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-latest-universal.cfg" "phoenix/releases/latest/universal"
}

# Push Phoenix for a desired platform
function _push_phoenix() {
  function print_usage() {
    echo "Usage: _push_phoenix 'platform'"
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

  push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.${phoenix_archive_type}" "phoenix/releases/${PHOENIX_VERSION}/${phoenix_platform}"

  # Ensure the latest version can always be downloaded from https://releases.celenity.dev/phoenix/releases/latest/{phoenix_platform}/phoenix-latest-{phoenix_platform}.${phoenix_archive_type}
  ## (Ex. for convenience/packaging)
  "${PHOENIX_CP}" -f "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.${phoenix_archive_type}" "${PHOENIX_ARTIFACTS}/phoenix-latest-${phoenix_platform}.${phoenix_archive_type}"
  push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-latest-${phoenix_platform}.${phoenix_archive_type}" "phoenix/releases/latest/${phoenix_platform}"

  # For Android, also push phoenix.js and phoenix-extended.js directly
  if [[ "${phoenix_platform}" == 'android' ]]; then
    push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.js" "phoenix/releases/${PHOENIX_VERSION}/${phoenix_platform}"
    push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-extended-${PHOENIX_VERSION}-${phoenix_platform}.js" "phoenix/releases/${PHOENIX_VERSION}/${phoenix_platform}"

    # Ensure the latest version can always be downloaded from https://releases.celenity.dev/phoenix/releases/latest/{phoenix_platform}/phoenix-latest-{phoenix_platform}.js
    ## (and https://releases.celenity.dev/phoenix/releases/latest/{phoenix_platform}/phoenix-extended-latest-{phoenix_platform}.js)
    ## (Ex. for convenience/packaging)
    "${PHOENIX_CP}" -f "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-${phoenix_platform}.js" "${PHOENIX_ARTIFACTS}/phoenix-latest-${phoenix_platform}.js"
    push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-latest-${phoenix_platform}.js" "phoenix/releases/latest/${phoenix_platform}"

    "${PHOENIX_CP}" -f "${PHOENIX_ARTIFACTS}/phoenix-extended-${PHOENIX_VERSION}-${phoenix_platform}.js" "${PHOENIX_ARTIFACTS}/phoenix-extended-latest-${phoenix_platform}.js"
    push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-extended-latest-${phoenix_platform}.js" "phoenix/releases/latest/${phoenix_platform}"
  fi
}

# Push Phoenix to S3 storage
function push_phoenix() {
  # Android
  _push_phoenix 'android'

  # Linux
  _push_phoenix 'linux'

  # Linux (Flatpak)
  _push_phoenix 'linux-flatpak'

  # OS X
  _push_phoenix 'osx'

  # OS X (Intel)
  _push_phoenix 'osx-intel'

  # Windows
  _push_phoenix 'windows'

  # Universal cfg
  push_phoenix_universal

  # Update the current Phoenix version
  "${PHOENIX_MKDIR}" -p "${PHOENIX_TEMP}"
  "${PHOENIX_TOUCH}" "${PHOENIX_TEMP}/latest_release.txt"
  echo -n "${PHOENIX_VERSION}" > "${PHOENIX_TEMP}/latest_release.txt"
  push_and_add_sha512sum "${PHOENIX_TEMP}/latest_release.txt" 'phoenix/releases'

  # Add release notes
  push_and_add_sha512sum "${PHOENIX_ARTIFACTS}/phoenix-${PHOENIX_VERSION}-release-notes.md" "phoenix/releases/${PHOENIX_VERSION}"

  echo_green_text "SUCCESS: Pushed Phoenix: ${PHOENIX_VERSION} to ${PHOENIX_CEL_RELEASES_URL}"
}

# First, create our release notes
create_release_notes

# Push Phoenix to S3
push_phoenix

# Create a Forgejo (Codeberg) release
publish_to_forgejo

# Create a GitLab release
publish_to_gitlab

# Create a GitHub release
publish_to_github
