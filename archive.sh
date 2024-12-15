#!/bin/bash

# This is a basic script used to create the .zip files you see in the 'archives' directory.
# We could just clone the entire source code - though lots of of it are completely unnecessary for packaging.
# This creates a slim .zip file only containing what we actually need.

# Script should be ran from inside the directory where you store Phoenix, not directly from this 'archives' folder...

# For now I'm specifying specific files - though in the future (once migration to the New Phoenix is complete & the source code is cleaned up...), we can probably just use certain directories
zip -R archives/phoenix.zip 'filter.pac' 'configs/Dev/dev.cfg' 'configs/Discord/discord.cfg' 'configs/Firefox-UI-Fix/dev.cfg' 'configs/Firefox-UI-Fix/discord.cfg' 'configs/Firefox-UI-Fix/hardened.cfg' 'configs/Firefox-UI-Fix/hardened-no-sync.cfg' 'configs/Firefox-UI-Fix/no-sync.cfg' 'configs/Firefox-UI-Fix/twitter.cfg' 'configs/Firefox-UI-Fix/youtube.cfg' 'configs/Hardened/hardened.cfg' 'configs/Hardened-No-Sync/hardened-no-sync.cfg' 'configs/No-Sync/no-sync.cfg' 'configs/Twitter/twitter.cfg' 'configs/YouTube/youtube.cfg' 'defaults/pref/phoenix.js' 'etc/profile.d/phoenix-env-overrides.sh' 'phoenix.cfg' 'policies/Policies/policies.json' 'README.md'