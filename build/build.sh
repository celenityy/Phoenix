#!/usr/bin/env bash

source build/env.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Update "browser.phoenix.version"
    sed -i '' "s/pref(\"browser.phoenix.version\", \".*\", locked);/pref(\"browser.phoenix.version\", \"$phoenix_version\", locked);/" build/phoenix-unified.js
    # Update "distribution.about"
    sed -i '' "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/phoenix-unified.js
    sed -i '' "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix: Extended for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/phoenix-extended-unified.js
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Apple Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/apple-maps-unified.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Discord SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/discord-unified.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Element SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/element-unified.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Google Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/google-maps-unified.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Twitter SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/twitter-unified.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: YouTube SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/youtube-unified.cfg
else
    # Update "browser.phoenix.version"
    sed -i "s/pref(\"browser.phoenix.version\", \".*\", locked);/pref(\"browser.phoenix.version\", \"$phoenix_version\", locked);/" build/phoenix-unified.js
    # Update "distribution.about"
    sed -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/phoenix-unified.js
    sed -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix: Extended for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/phoenix-extended-unified.js
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Apple Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/apple-maps-unified.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Discord SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/discord-unified.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Element SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/element-unified.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Google Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/google-maps-unified.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Twitter SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/twitter-unified.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: YouTube SC for Mozilla Firefox - $phoenix_version 💜\");/" build/specialized-configs/youtube-unified.cfg
fi

./build/fly.sh && ./build/gen_archive.sh
