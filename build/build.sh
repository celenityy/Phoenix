#!/usr/bin/env bash

source build/env.sh

# Update "browser.phoenix.version"
$SED -i "s/pref(\"browser.phoenix.version\", \".*\", locked);/pref(\"browser.phoenix.version\", \"$phoenix_version\", locked);/" build/phoenix-unified.js

# Update "distribution.about"
$SED -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/phoenix-unified.js
$SED -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix: Extended for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/phoenix-extended-unified.js
$SED -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Apple Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/apple-maps-unified.cfg
$SED -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Discord SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/discord-unified.cfg
$SED -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Element SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/element-unified.cfg
$SED -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Google Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/google-maps-unified.cfg
$SED -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Twitter SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/twitter-unified.cfg
$SED -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: YouTube SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/youtube-unified.cfg

./build/fly.sh && ./build/gen_archive.sh
