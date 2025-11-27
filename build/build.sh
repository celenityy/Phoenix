#!/usr/bin/env bash

set -eu

source build/env.sh

# Update the version
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/phoenix-extended-unified.js
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/phoenix-unified.js
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/specialized-configs/apple-maps-unified.cfg
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/specialized-configs/element-unified.cfg
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/specialized-configs/google-maps-unified.cfg
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/specialized-configs/photopea-unified.cfg
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/specialized-configs/twitter-unified.cfg
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/specialized-configs/youtube-music-unified.cfg
$SED -i "s|{PHOENIX_VERSION}|$PHOENIX_VERSION|" build/specialized-configs/youtube-unified.cfg

./build/fly.sh && ./build/gen_archive.sh
