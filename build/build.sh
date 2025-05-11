#!/usr/bin/env bash

source build/env.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Update "browser.phoenix.version"
    sed -i '' "s/pref(\"browser.phoenix.version\", \".*\", locked);/pref(\"browser.phoenix.version\", \"$phoenix_version\", locked);/" build/prefs/phoenix-core.js
    # Update "distribution.about"
    sed -i '' "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/prefs/phoenix-desktop.js
    sed -i '' "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix: Extended for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/prefs/extended/phoenix-extended-desktop.js
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Apple Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/apple-maps-spec.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Discord SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/discord-spec.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Element SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/element-spec.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Google Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/google-maps-spec.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Twitter SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/twitter-spec.cfg
    sed -i '' "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: YouTube SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/youtube-spec.cfg
else
    # Update "browser.phoenix.version"
    sed -i "s/pref(\"browser.phoenix.version\", \".*\", locked);/pref(\"browser.phoenix.version\", \"$phoenix_version\", locked);/" build/prefs/phoenix-core.js
    # Update "distribution.about"
    sed -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/prefs/phoenix-desktop.js
    sed -i "s/pref(\"distribution.about\", \".*\", locked);/pref(\"distribution.about\", \"Phoenix: Extended for Mozilla Firefox - $phoenix_version 💜\", locked);/" build/prefs/extended/phoenix-extended-desktop.js
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Apple Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/apple-maps-spec.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Discord SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/discord-spec.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Element SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/element-spec.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Google Maps SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/google-maps-spec.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: Twitter SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/twitter-spec.cfg
    sed -i "s/lockPref(\"distribution.about\", \".*\");/lockPref(\"distribution.about\", \"Phoenix: YouTube SC for Mozilla Firefox - $phoenix_version 💜\");/" build/configs/youtube-spec.cfg
fi

./build/gen_desktop.sh && ./build/gen_macos.sh && ./build/gen_android.sh && ./build/gen_policies.sh && ./build/gen_archive.sh
