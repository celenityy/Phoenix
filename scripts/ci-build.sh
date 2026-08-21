#!/bin/bash

set -euo pipefail

# Set-up our environment
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

# Set verbosity
if [[ "${PHOENIX_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: $0 should only be called from CI!"
  exit 1
fi

# Get dependencies
echo_red_text 'CI - Downloading dependencies...'
/bin/sudo /bin/dnf update -y --refresh
/bin/sudo /bin/dnf install -y bash curl jq shasum tar zip
/bin/bash "${PHOENIX_SCRIPTS}/get_sources.sh" 'all'
/bin/bash "${PHOENIX_SCRIPTS}/get_sources.sh" 's3cmd'
echo_green_text 'CI - SUCCESS: Downloaded dependencies.'

# Get secrets
echo_red_text 'CI - Preparing secrets...'
set +x
/bin/bash "${PHOENIX_SCRIPTS}/ci-prep.sh" 's3-artifacts'
echo_green_text 'CI - SUCCESS: Prepared secrets.'

# Set verbosity
if [[ "${PHOENIX_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

# Build Phoenix
echo_red_text 'CI - Building Phoenix...'
/bin/bash "${PHOENIX_SCRIPTS}/build.sh" 'all'
echo_green_text 'CI - SUCCESS: Built Phoenix.'

# Upload artifacts
echo_red_text 'CI - Uploading artifacts...'
set +x
/bin/bash "${PHOENIX_SCRIPTS}/ci-upload-artifacts.sh" 'all'
echo_green_text 'CI - SUCCESS: Uploaded artifacts.'
