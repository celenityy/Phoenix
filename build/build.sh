#!/usr/bin/env bash

source build/env.sh

# Update `browser.phoenix.version`
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/pref(\"browser.phoenix.version\", \".*\", locked);/pref(\"browser.phoenix.version\", \"$phoenix_version\", locked);/" build/prefs/phoenix-core.js
else
    sed -i "s/pref(\"browser.phoenix.version\", \".*\", locked);/pref(\"browser.phoenix.version\", \"$phoenix_version\", locked);/" build/prefs/phoenix-core.js
fi

./build/gen_desktop.sh && ./build/gen_macos.sh && ./build/gen_android.sh && ./build/gen_policies.sh && ./build/gen_archive.sh
