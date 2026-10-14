#!/bin/bash
set -euo pipefail
exec /bin/bash -c "echo $@" || exit 1
