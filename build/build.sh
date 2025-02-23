#!/usr/bin/env bash

./build/gen_desktop.sh && ./build/gen_macos.sh && ./build/gen_android.sh && ./build/gen_policies.sh && ./build/gen_archive.sh
