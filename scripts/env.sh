#!/bin/bash

# Phoenix environment variables

set -euo pipefail

if [[ ! -f "$(dirname $0)/env_local.sh" ]]; then
  readonly ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  readonly ENV_LOCAL="${ROOT}/scripts/env_local.sh"

  # Write env_local.sh
  echo "Writing ${ENV_LOCAL}..."
  cat >"${ENV_LOCAL}" <<EOF
readonly PHOENIX_ROOT="${ROOT}"
export PHOENIX_ROOT

source "\${PHOENIX_ROOT}/scripts/env_common.sh"
EOF
fi

if [[ -z "${PHOENIX_SET_ENVS+x}" ]]; then
  source "$(dirname $0)/env_local.sh"
fi
