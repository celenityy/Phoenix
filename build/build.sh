#!/usr/bin/env bash

set -eu

source build/env.sh

./build/fly.sh && ./build/gen_archive.sh
