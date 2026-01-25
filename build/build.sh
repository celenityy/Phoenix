#!/bin/bash

set -euo pipefail

# Set-up our environment
bash -x $(dirname $0)/env.sh
source $(dirname $0)/env.sh

bash -x "${PHOENIX_BUILD}/fly.sh" && bash -x "${PHOENIX_BUILD}/gen_archive.sh"
