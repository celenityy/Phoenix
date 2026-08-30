#!/bin/bash

set -euo pipefail

# Set-up our environment
source $(dirname $0)/env.sh || exit 1

# Include utilities
source "${PHOENIX_UTILS}" || exit 1

# Set verbosity
set_verbosity

if [[ "${PHOENIX_CI}" != 1 ]]; then
  echo_red_text "ERROR: '$0' should only be called from CI!"
  exit 1
fi

# Get dependencies
echo_red_text 'CI - Downloading dependencies...'
/bin/sudo /bin/dnf update -y --refresh || exit 1
/bin/sudo /bin/dnf install -y bash curl jq shasum tar zip || exit 1
/bin/bash "${PHOENIX_SCRIPTS}/get_sources.sh" 'all' || exit 1
/bin/bash "${PHOENIX_SCRIPTS}/get_sources.sh" 's3cmd' || exit 1
echo_green_text 'CI - SUCCESS: Downloaded dependencies.'

# Get secrets
echo_red_text 'CI - Preparing secrets...'
set +x || exit 1
/bin/bash "${PHOENIX_SCRIPTS}/ci-prep.sh" 's3-artifacts' || exit 1
echo_green_text 'CI - SUCCESS: Prepared secrets.'

# Set verbosity
set_verbosity

# Build Phoenix
echo_red_text 'CI - Building Phoenix...'
/bin/bash "${PHOENIX_SCRIPTS}/build.sh" 'all' || exit 1
echo_green_text 'CI - SUCCESS: Built Phoenix.'

# Upload artifacts
echo_red_text 'CI - Uploading artifacts...'
set +x || exit 1
/bin/bash "${PHOENIX_SCRIPTS}/ci-upload-artifacts.sh" 'all' || exit 1
echo_green_text 'CI - SUCCESS: Uploaded artifacts.'
