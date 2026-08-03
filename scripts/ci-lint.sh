#!/bin/bash

set -euo pipefail

# Set-up our environment
if [[ -z "${PHOENIX_CI+x}" ]]; then
  export PHOENIX_CI=1
fi
source $(dirname $0)/env.sh

# Include utilities
source "${PHOENIX_UTILS}"

# Set verbosity
if [[ "${PHOENIX_VERBOSE}" == 1 ]]; then
  set -x
else
  set +x
fi

# Get dependencies
echo_red_text 'CI - Downloading dependencies...'
/bin/sudo /bin/dnf update -y --refresh
/bin/sudo /bin/dnf install -y bash curl git tar
/bin/bash "${PHOENIX_SCRIPTS}/get_sources.sh" 'shellcheck'
/bin/bash "${PHOENIX_SCRIPTS}/get_sources.sh" 'shfmt'
echo_green_text 'CI - SUCCESS: Downloaded dependencies.'

# Lint our scripts
echo_red_text 'CI - Linting scripts...'
/bin/bash "${PHOENIX_SCRIPTS}/lint.sh"
echo_green_text 'CI - SUCCESS: Linted scripts.'
