#!/bin/bash
set -euo pipefail
exec "${PHOENIX_BASH}" -c "echo $@" || exit 1
